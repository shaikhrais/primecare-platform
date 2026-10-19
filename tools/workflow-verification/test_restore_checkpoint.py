"""Checkpoint hydration checks use disposable synthetic SQLite databases only."""
import gzip
import json
from pathlib import Path
import sqlite3
import tempfile
import unittest
from unittest.mock import patch

from restore_checkpoint import CheckpointError, digest, restore_checkpoint


class RestoreCheckpointTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.target = self.root / 'governance.db'
        self.latest = self.root / 'latest.db'
        self.archive = self.root / 'snapshot.db.gz'
        self.manifest_path = self.root / 'manifest.json'
        self.database(self.target, 'baseline business data')
        self.database(self.latest, 'published workflow catalogue')
        self.baseline = self.target.read_bytes()
        self.archive.write_bytes(gzip.compress(self.latest.read_bytes(), mtime=0))
        self.manifest = {'database': 'governance.db', 'snapshot': 'snapshot.db.gz',
                         'database_sha256': digest(self.latest), 'snapshot_sha256': digest(self.archive),
                         'database_bytes': self.latest.stat().st_size, 'snapshot_bytes': self.archive.stat().st_size,
                         'bootstrap_allowed_database_sha256': [digest(self.target)]}
        self.save_manifest()

    def database(self, path, value):
        with sqlite3.connect(path) as db:
            db.execute('CREATE TABLE records(value TEXT)')
            db.execute('INSERT INTO records VALUES(?)', (value,))

    def save_manifest(self):
        self.manifest_path.write_text(json.dumps(self.manifest))

    def restore(self):
        return restore_checkpoint(self.root, self.manifest_path)

    def test_known_baseline_is_preserved_before_atomic_restore_and_second_run_is_noop(self):
        result = self.restore()
        self.assertEqual(result['status'], 'restored')
        self.assertEqual(Path(result['backup']).read_bytes(), self.baseline)
        self.assertEqual(self.target.read_bytes(), self.latest.read_bytes())
        before = self.target.stat().st_mtime_ns
        self.assertEqual(self.restore()['status'], 'current')
        self.assertEqual(self.target.stat().st_mtime_ns, before)
        with sqlite3.connect(result['backup']) as db:
            self.assertEqual(db.execute('SELECT value FROM records').fetchone()[0], 'baseline business data')

    def test_unknown_local_changes_are_never_overwritten_and_copy_is_reusable(self):
        with sqlite3.connect(self.target) as db:
            db.execute("INSERT INTO records VALUES('unpublished work')")
        original = self.target.read_bytes()
        result = self.restore()
        self.assertEqual(result['status'], 'needs_reconciliation')
        self.assertEqual(self.target.read_bytes(), original)
        self.assertEqual(Path(result['checkpoint']).read_bytes(), self.latest.read_bytes())
        self.assertEqual(self.restore()['checkpoint'], result['checkpoint'])

    def test_no_allowlist_does_not_authorize_replacing_existing_database(self):
        del self.manifest['bootstrap_allowed_database_sha256']
        self.save_manifest()
        self.assertEqual(self.restore()['status'], 'needs_reconciliation')
        self.assertEqual(self.target.read_bytes(), self.baseline)

    def test_absent_target_can_receive_verified_checkpoint(self):
        self.target.unlink()
        result = self.restore()
        self.assertEqual(result['status'], 'restored')
        self.assertIsNone(result['backup'])
        self.assertEqual(self.target.read_bytes(), self.latest.read_bytes())

    def test_compressed_hash_and_size_mismatches_preserve_target(self):
        original = dict(self.manifest)
        for field, value in [('snapshot_sha256', '0' * 64), ('snapshot_bytes', 1)]:
            self.manifest = {**original, field: value}
            self.save_manifest()
            with self.assertRaises(CheckpointError):
                self.restore()
            self.assertEqual(self.target.read_bytes(), self.baseline)

    def test_expanded_hash_and_size_mismatches_preserve_target(self):
        original = dict(self.manifest)
        for field, value in [('database_sha256', '0' * 64), ('database_bytes', 1), ('database_bytes', self.latest.stat().st_size + 1)]:
            self.manifest = {**original, field: value}
            self.save_manifest()
            with self.assertRaises(CheckpointError):
                self.restore()
            self.assertEqual(self.target.read_bytes(), self.baseline)

    def test_hash_valid_non_sqlite_payload_is_rejected(self):
        payload = b'not a sqlite database'
        self.latest.write_bytes(payload)
        self.archive.write_bytes(gzip.compress(payload, mtime=0))
        self.manifest.update(database_sha256=digest(self.latest), database_bytes=len(payload),
                             snapshot_sha256=digest(self.archive), snapshot_bytes=self.archive.stat().st_size)
        self.save_manifest()
        with self.assertRaises(CheckpointError):
            self.restore()
        self.assertEqual(self.target.read_bytes(), self.baseline)

    def test_hash_valid_invalid_gzip_is_rejected_without_installation(self):
        self.archive.write_bytes(b'not a gzip stream')
        self.manifest.update(snapshot_sha256=digest(self.archive), snapshot_bytes=self.archive.stat().st_size)
        self.save_manifest()
        with self.assertRaises(CheckpointError):
            self.restore()
        self.assertEqual(self.target.read_bytes(), self.baseline)

    def test_local_wal_or_journal_state_requires_reconciliation_even_for_known_bytes(self):
        for suffix in ['-wal', '-shm', '-journal']:
            sidecar = Path(str(self.target) + suffix)
            sidecar.write_bytes(b'local transactional state')
            try:
                self.assertEqual(self.restore()['status'], 'needs_reconciliation')
                self.assertEqual(self.target.read_bytes(), self.baseline)
                self.assertEqual(sidecar.read_bytes(), b'local transactional state')
            finally:
                sidecar.unlink()

    def test_malicious_manifest_paths_and_allowlist_fail_closed(self):
        original = dict(self.manifest)
        for field, value in [('database', '../outside.db'), ('snapshot', str(self.archive)), ('bootstrap_allowed_database_sha256', ['not-a-hash'])]:
            self.manifest = {**original, field: value}
            self.save_manifest()
            with self.assertRaises(CheckpointError):
                self.restore()
            self.assertEqual(self.target.read_bytes(), self.baseline)

    def test_symlink_target_is_not_followed_or_replaced(self):
        original = self.root / 'valuable.db'
        self.target.rename(original)
        self.target.symlink_to(original)
        with self.assertRaises(CheckpointError):
            self.restore()
        self.assertTrue(self.target.is_symlink())
        self.assertEqual(original.read_bytes(), self.baseline)

    def test_unrelated_preexisting_backup_is_never_replaced(self):
        backup = self.target.with_name(self.target.name + '.baseline-' + digest(self.target) + '.bak')
        backup.write_bytes(b'important different bytes')
        result = self.restore()
        self.assertEqual(result['status'], 'restored')
        self.assertNotEqual(Path(result['backup']), backup)
        self.assertEqual(backup.read_bytes(), b'important different bytes')
        self.assertEqual(Path(result['backup']).read_bytes(), self.baseline)

    def test_change_after_backup_is_preserved_for_reconciliation(self):
        from restore_checkpoint import preserve_copy
        def concurrent_change(source, destination, expected):
            result = preserve_copy(source, destination, expected)
            if source == self.target:
                with sqlite3.connect(self.target) as db:
                    db.execute("INSERT INTO records VALUES('concurrent local work')")
            return result
        with patch('restore_checkpoint.preserve_copy', side_effect=concurrent_change):
            result = self.restore()
        self.assertEqual(result['status'], 'needs_reconciliation')
        with sqlite3.connect(self.target) as db:
            self.assertIn(('concurrent local work',), db.execute('SELECT value FROM records').fetchall())


if __name__ == '__main__':
    unittest.main()
