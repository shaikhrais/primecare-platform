#!/usr/bin/env python3
import importlib.util
import plistlib
import tempfile
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('macos_entitlements', Path(__file__).with_name('prepare-macos-entitlements.py'))
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)


class MacOSCapabilitiesTest(unittest.TestCase):
    def test_preparation_preserves_existing_capabilities_and_is_idempotent(self):
        with tempfile.TemporaryDirectory() as temporary:
            runner = Path(temporary) / 'macos/Runner'
            runner.mkdir(parents=True)
            original = {module.SANDBOX: True, 'com.apple.security.cs.allow-jit': True}
            for name in ('DebugProfile.entitlements', 'Release.entitlements'):
                (runner / name).write_bytes(plistlib.dumps(original))
            module.prepare(temporary)
            module.prepare(temporary)
            for path in runner.glob('*.entitlements'):
                values = plistlib.loads(path.read_bytes())
                self.assertEqual(values, {**original, module.NETWORK_CLIENT: True})
                self.assertNotIn('com.apple.security.network.server', values)

    def test_disabled_sandbox_is_rejected(self):
        with tempfile.TemporaryDirectory() as temporary:
            runner = Path(temporary) / 'macos/Runner'
            runner.mkdir(parents=True)
            (runner / 'DebugProfile.entitlements').write_bytes(plistlib.dumps({module.SANDBOX: False}))
            with self.assertRaisesRegex(ValueError, 'sandbox must remain enabled'):
                module.prepare(temporary)

    def test_missing_entitlement_source_is_rejected(self):
        with tempfile.TemporaryDirectory() as temporary:
            with self.assertRaises(FileNotFoundError):
                module.prepare(temporary)

    def test_missing_built_application_is_rejected(self):
        with tempfile.TemporaryDirectory() as temporary:
            with self.assertRaisesRegex(ValueError, 'Expected one macOS application'):
                module.verify_built(temporary)


if __name__ == '__main__':
    unittest.main()
