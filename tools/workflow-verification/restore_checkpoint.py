"""Hydrate the published governance checkpoint without discarding local work.

Run before opening governance.db in another process. Only a byte-exact baseline
explicitly allowlisted by the manifest may be replaced, and that baseline is
preserved first. An unfamiliar database is never overwritten or merged.
"""
import argparse
import gzip
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import sqlite3
import tempfile
import zlib

ROOT = Path(__file__).resolve().parents[2]
MANIFEST = 'docs/task-progress/database-snapshot.json'
CHUNK_BYTES = 1024 * 1024


class CheckpointError(ValueError):
    """An untrusted or inconsistent checkpoint must not be installed."""


def digest(path):
    value = hashlib.sha256()
    with Path(path).open('rb') as stream:
        for chunk in iter(lambda: stream.read(CHUNK_BYTES), b''):
            value.update(chunk)
    return value.hexdigest()


def project_path(root, name):
    if not isinstance(name, str) or not name or Path(name).is_absolute():
        raise CheckpointError('Manifest paths must be relative project paths')
    candidate = root / name
    if candidate.is_symlink():
        raise CheckpointError('Checkpoint paths must not be symbolic links: ' + name)
    resolved = candidate.resolve()
    if not resolved.is_relative_to(root):
        raise CheckpointError('Checkpoint path is outside the project: ' + name)
    return resolved


def verified_manifest(path):
    try:
        manifest = json.loads(path.read_text())
    except (OSError, ValueError) as error:
        raise CheckpointError('Checkpoint manifest cannot be read: ' + str(error)) from error
    if not isinstance(manifest, dict):
        raise CheckpointError('Checkpoint manifest must be a JSON object')
    for key in ['database_sha256', 'snapshot_sha256']:
        if not isinstance(manifest.get(key), str) or not re.fullmatch('[a-f0-9]{64}', manifest[key]):
            raise CheckpointError('Invalid checkpoint SHA256: ' + key)
    for key in ['database_bytes', 'snapshot_bytes']:
        if type(manifest.get(key)) is not int or manifest[key] < 1:
            raise CheckpointError('Invalid checkpoint byte count: ' + key)
    allowed = manifest.get('bootstrap_allowed_database_sha256', [])
    if not isinstance(allowed, list) or any(not isinstance(value, str) or not re.fullmatch('[a-f0-9]{64}', value) for value in allowed):
        raise CheckpointError('Invalid bootstrap database allowlist')
    return manifest


def verify_sqlite(path):
    try:
        db = sqlite3.connect(path.as_uri() + '?mode=ro&immutable=1', uri=True)
        try:
            rows = db.execute('PRAGMA integrity_check').fetchall()
            if rows != [('ok',)]:
                raise CheckpointError('Checkpoint SQLite integrity check failed')
        finally:
            db.close()
    except sqlite3.Error as error:
        raise CheckpointError('Checkpoint is not a valid SQLite database: ' + str(error)) from error


def sqlite_sidecars(target):
    return [str(Path(str(target) + suffix)) for suffix in ['-wal', '-shm', '-journal'] if Path(str(target) + suffix).exists()]


def sync_directory(path):
    if os.name != 'posix':
        return
    descriptor = os.open(path, os.O_RDONLY | getattr(os, 'O_DIRECTORY', 0))
    try:
        os.fsync(descriptor)
    finally:
        os.close(descriptor)


def preserve_copy(source, candidate, expected_hash):
    """Atomically create a copy; existing files are never replaced."""
    for number in range(100):
        destination = candidate if number == 0 else candidate.with_name(candidate.name + '.' + str(number))
        if destination.exists() or destination.is_symlink():
            if not destination.is_symlink() and destination.is_file() and digest(destination) == expected_hash:
                return destination
            continue
        descriptor, name = tempfile.mkstemp(prefix='.checkpoint-copy-', dir=destination.parent)
        temporary = Path(name)
        try:
            with os.fdopen(descriptor, 'wb') as output, source.open('rb') as original:
                shutil.copyfileobj(original, output, CHUNK_BYTES)
                output.flush()
                os.fsync(output.fileno())
            if digest(temporary) != expected_hash:
                raise CheckpointError('Database changed while preserving its bytes; nothing installed')
            try:
                os.link(temporary, destination)
            except FileExistsError:
                continue
            sync_directory(destination.parent)
            return destination
        finally:
            temporary.unlink(missing_ok=True)
    raise CheckpointError('Cannot allocate a preserved checkpoint path without replacing another file')


def restore_checkpoint(root=ROOT, manifest_path=None):
    """Return current/restored/needs_reconciliation; malformed evidence raises.

    A restored result includes the preserved baseline path. Reconciliation
    results include a verified separate checkpoint and leave the target intact.
    """
    root = Path(root).resolve()
    manifest_path = Path(manifest_path) if manifest_path is not None else root / MANIFEST
    if not manifest_path.is_absolute():
        manifest_path = root / manifest_path
    manifest = verified_manifest(manifest_path)
    target = project_path(root, manifest.get('database'))
    archive = project_path(root, manifest.get('snapshot'))
    if target == archive:
        raise CheckpointError('Database and compressed snapshot paths must be different')
    if not archive.is_file() or archive.stat().st_size != manifest['snapshot_bytes'] or digest(archive) != manifest['snapshot_sha256']:
        raise CheckpointError('Compressed snapshot SHA256 or byte count does not match the manifest')
    target.parent.mkdir(parents=True, exist_ok=True)
    descriptor, name = tempfile.mkstemp(prefix='.checkpoint-verified-', suffix='.db', dir=target.parent)
    staging = Path(name)
    try:
        expanded_hash = hashlib.sha256()
        total = 0
        try:
            with os.fdopen(descriptor, 'wb') as output, gzip.open(archive, 'rb') as compressed:
                while chunk := compressed.read(min(CHUNK_BYTES, manifest['database_bytes'] - total + 1)):
                    total += len(chunk)
                    if total > manifest['database_bytes']:
                        raise CheckpointError('Expanded snapshot exceeds its registered byte count')
                    expanded_hash.update(chunk)
                    output.write(chunk)
                output.flush()
                os.fsync(output.fileno())
        except (OSError, EOFError, zlib.error) as error:
            raise CheckpointError('Compressed snapshot could not be expanded: ' + str(error)) from error
        expected = manifest['database_sha256']
        if total != manifest['database_bytes'] or expanded_hash.hexdigest() != expected:
            raise CheckpointError('Expanded database SHA256 or byte count does not match the manifest')
        verify_sqlite(staging)
        result = {'database': str(target), 'database_sha256': expected, 'snapshot': str(archive)}

        def reconcile(reason):
            candidate = target.with_name(target.stem + '.checkpoint-' + expected + target.suffix)
            separate = preserve_copy(staging, candidate, expected)
            return {**result, 'status': 'needs_reconciliation', 'checkpoint': str(separate), 'reason': reason}

        if sqlite_sidecars(target):
            return reconcile('Local SQLite WAL/journal state exists. Close database users and reconcile the preserved checkpoint; no target was overwritten.')
        if not target.exists():
            try:
                os.link(staging, target)
            except FileExistsError:
                return reconcile('A local database appeared during validation; it was preserved.')
            sync_directory(target.parent)
            return {**result, 'status': 'restored', 'backup': None, 'reason': 'Installed verified checkpoint into an absent target.'}
        if not target.is_file() or target.is_symlink():
            return reconcile('The target is not a regular database file; it was preserved.')
        current = digest(target)
        if current == expected:
            return {**result, 'status': 'current', 'reason': 'Target already matches the complete verified checkpoint.'}
        if current not in manifest.get('bootstrap_allowed_database_sha256', []):
            return reconcile('Local database differs from the checkpoint and every allowlisted baseline. Reconcile explicitly; local data was preserved.')
        backup = preserve_copy(target, target.with_name(target.name + '.baseline-' + current + '.bak'), current)
        if sqlite_sidecars(target) or target.is_symlink() or digest(target) != current:
            return reconcile('Local database or SQLite sidecars changed during validation; target was preserved.')
        os.replace(staging, target)
        sync_directory(target.parent)
        return {**result, 'status': 'restored', 'backup': str(backup), 'reason': 'Replaced only an exact allowlisted baseline after preserving its complete bytes.'}
    finally:
        staging.unlink(missing_ok=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, default=ROOT)
    parser.add_argument('--manifest', type=Path)
    args = parser.parse_args()
    try:
        result = restore_checkpoint(args.root, args.manifest)
    except (CheckpointError, OSError) as error:
        print(json.dumps({'status': 'error', 'reason': str(error)}))
        return 1
    print(json.dumps(result))
    return 2 if result['status'] == 'needs_reconciliation' else 0


if __name__ == '__main__':
    raise SystemExit(main())
