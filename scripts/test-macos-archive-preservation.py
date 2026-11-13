"""Pure archive fixtures; these do not execute a native application locally."""
import importlib.util
import io
import stat
import tarfile
import tempfile
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('macos_package', Path(__file__).with_name('package-test-macos-build.py'))
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)


class Preservation(unittest.TestCase):
    def test_framework_aliases_executable_mode_and_binary_bytes_survive(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            app = root / 'products/Fixture.app'
            framework = app / 'Contents/Frameworks/Fixture.framework'
            binary = framework / 'Versions/A/Fixture'
            binary.parent.mkdir(parents=True)
            binary.write_bytes(b'fixture-binary\x00')
            binary.chmod(0o755)
            (framework / 'Versions/Current').symlink_to('A')
            (framework / 'Fixture').symlink_to('Versions/Current/Fixture')
            archive = root / 'app.tar'
            m.archive_application(app, archive)
            restored = m.extract_application(archive, root / 'restored')
            alias = restored / 'Contents/Frameworks/Fixture.framework/Fixture'
            self.assertTrue(alias.is_symlink())
            self.assertEqual(alias.readlink(), Path('Versions/Current/Fixture'))
            self.assertEqual(alias.read_bytes(), binary.read_bytes())
            self.assertEqual(stat.S_IMODE(alias.stat().st_mode), 0o755)
            self.assertTrue((alias.parent / 'Versions/Current').is_symlink())

    def test_missing_multiple_or_symlink_application_is_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            with self.assertRaises(ValueError): m.application(root)
            (root / 'One.app').mkdir()
            (root / 'Two.app').mkdir()
            with self.assertRaises(ValueError): m.application(root)
            (root / 'Two.app').rmdir()
            (root / 'One.app').rmdir()
            (root / 'One.app').symlink_to(root, target_is_directory=True)
            with self.assertRaises(ValueError): m.application(root)

    def test_archive_cannot_write_outside_extraction_directory(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            archive = root / 'bad.tar'
            with tarfile.open(archive, 'w') as contents:
                item = tarfile.TarInfo('../outside')
                item.size = 1
                contents.addfile(item, io.BytesIO(b'x'))
            with self.assertRaises(tarfile.FilterError):
                m.extract_application(archive, root / 'restored')
            self.assertFalse((root / 'outside').exists())


if __name__ == '__main__': unittest.main()
