"""Inventory tracked files, then retire only the reviewed pre-skeleton backup.

Run without --apply for a dry run. Recovery uses an existing Git commit; no
business behavior is reconstructed from filenames or inferred declarations.
"""
import argparse
import csv
import gzip
import hashlib
import io
import json
import re
import subprocess
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BACKUP = 'generated_screen_backup_before_template_reset'
OUTPUT = ROOT / 'docs/refactoring/legacy-retirement-20261011'
TEXT = {'.dart', '.ts', '.tsx', '.js', '.jsx', '.mjs', '.cjs', '.py', '.sql', '.prisma', '.html', '.css', '.md', '.json', '.yaml', '.yml', '.toml', '.sh', '.ps1', '.java', '.kt', '.swift', '.txt'}


def git(*args):
    return subprocess.check_output(['git', *args], cwd=ROOT).decode()


def purpose(path):
    name = Path(path).name
    if '/sections/' in path:
        return 'screen section'
    if '/state/' in path or 'provider.dart' in name:
        return 'screen state/provider'
    if '/models/' in path or name.endswith('_model.dart'):
        return 'data model'
    if '/services/' in path or name.endswith('_api.dart'):
        return 'service/API adapter'
    if '/routes/' in path or 'navigation' in name:
        return 'routing/navigation'
    if '/cypress/' in path or '.cy.' in name or '/test' in path:
        return 'test scenario'
    if name.endswith('_screen.dart'):
        return 'screen composition'
    if path.endswith(('.sql', '.prisma')):
        return 'database definition/migration'
    if path.startswith(('screenshots/', 'html_screen_previews/')):
        return 'historical screen preview'
    if path.startswith(('docs/', 'agent_context/')):
        return 'documentation/context'
    if path.startswith(('.github/', 'scripts/', 'tools/')):
        return 'automation/tooling'
    if path.startswith(('apps/', 'packages/', 'services/', 'cloudflare/')):
        return 'application/shared implementation or configuration'
    return 'supporting repository artifact'


def decision(path):
    if path.startswith(BACKUP + '/'):
        return 'delete_archived_backup'
    if path.startswith(('apps/', 'packages/', 'services/', 'cloudflare/', '.github/', 'scripts/')):
        return 'retain_runtime_contract_build_or_tooling'
    return 'retain_pending_dependency_and_behavior_review'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--recovery-commit', required=True)
    parser.add_argument('--expected-backup-tree', required=True, help='Tree identity verified in the recovery commit')
    parser.add_argument('--apply', action='store_true')
    args = parser.parse_args()
    entries = []
    for line in git('ls-files', '--stage').splitlines():
        metadata, path = line.split('\t', 1)
        mode, blob, stage = metadata.split()
        if stage != '0':
            raise ValueError('Resolve index conflicts before retirement')
        entries.append((path, mode, blob))
    candidates = [entry for entry in entries if entry[0].startswith(BACKUP + '/')]
    if not candidates:
        raise ValueError('Backup already retired; use the existing recorded inventory')
    local_tree = git('rev-parse', 'HEAD:' + BACKUP).strip()
    if local_tree != args.expected_backup_tree:
        raise ValueError('Recovery commit does not contain the exact backup tree')
    dirty = set(git('diff', '--name-only', 'HEAD', '--', BACKUP).splitlines())
    if dirty:
        raise ValueError('Backup has local or staged modifications; preserve them first')
    # Check every deletion against its indexed Git identity before writing/removing.
    for path, mode, blob in candidates:
        if mode != '100644' or (ROOT / path).is_symlink():
            raise ValueError('Unexpected deletion mode: ' + path)
        raw = (ROOT / path).read_bytes()
        actual = hashlib.sha1(b'blob ' + str(len(raw)).encode() + b'\0' + raw).hexdigest()
        if actual != blob:
            raise ValueError('Backup content changed: ' + path)
    OUTPUT.mkdir(parents=True, exist_ok=True)
    stream = io.StringIO(newline='')
    columns = ['path', 'decision', 'purpose', 'topic', 'git_blob', 'bytes', 'declarations', 'endpoint_references', 'importance', 'recovery_commit']
    writer = csv.DictWriter(stream, fieldnames=columns, lineterminator='\n')
    writer.writeheader()
    counts = Counter()
    roles = Counter()
    size = 0
    for path, mode, blob in entries:
        file = ROOT / path
        selected = decision(path)
        raw = file.read_bytes() if file.is_file() and file.suffix in TEXT else b''
        text = raw.decode('utf-8', errors='replace')
        declarations = sorted(set(re.findall(r'\b(?:class|interface|enum|abstract class)\s+([A-Za-z_]\w*)', text)))
        endpoints = sorted(set(re.findall(r'(?<![\w])/(?:v1|api)/[A-Za-z0-9_/{}/.:-]+', text)))
        kind = purpose(path)
        deleted = selected == 'delete_archived_backup'
        important = 'historical evidence; inspect Git source before future rewrite' if deleted else 'preserved; replacement/dependency completeness not established'
        writer.writerow({'path': path, 'decision': selected, 'purpose': kind,
                         'topic': file.stem.replace('_', ' '), 'git_blob': blob,
                         'bytes': file.stat().st_size if file.exists() else '',
                         'declarations': ';'.join(declarations), 'endpoint_references': ';'.join(endpoints),
                         'importance': important, 'recovery_commit': args.recovery_commit if deleted else ''})
        counts[selected] += 1
        if deleted:
            roles[kind] += 1
            size += file.stat().st_size
    data = stream.getvalue().encode()
    (OUTPUT / 'file-inventory.csv.gz').write_bytes(gzip.compress(data, mtime=0))
    summary = {'recoveryCommit': args.recovery_commit, 'localHeadAtInventory': git('rev-parse', 'HEAD').strip(),
               'backupTree': local_tree, 'trackedFilesReviewed': len(entries), 'decisions': dict(counts),
               'deletedPurposes': dict(roles), 'deletedBytes': size,
               'inventorySha256': hashlib.sha256(data).hexdigest(), 'applied': args.apply,
               'limitations': 'Purposes/topics are source-path classifications; declarations and endpoints are extracted evidence, not validated business requirements. Git retains full source. Retained decisions do not certify skeleton completion.'}
    (OUTPUT / 'summary.json').write_text(json.dumps(summary, indent=2) + '\n')
    if args.apply:
        for path, _, _ in candidates:
            (ROOT / path).unlink()
        for directory in sorted((ROOT / BACKUP).rglob('*'), key=lambda p: len(p.parts), reverse=True):
            if directory.is_dir() and not any(directory.iterdir()):
                directory.rmdir()
        if not any((ROOT / BACKUP).iterdir()):
            (ROOT / BACKUP).rmdir()
    print(json.dumps(summary, indent=2))


if __name__ == '__main__':
    main()
