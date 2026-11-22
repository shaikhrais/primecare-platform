import unittest
from .look_activation_scope import should_activate


class LookActivationScopeTest(unittest.TestCase):
    def test_developer_packages_and_dependency_changes_do_not_activate(self):
        self.assertFalse(should_activate('push', ['package-lock.json', 'package.json',
            'packages/primecare_kitchen_sink/lib/gallery.dart', '.github/workflows/look-manager.yml']))

    def test_existing_look_runtime_or_registration_changes_remain_eligible(self):
        for path in ['packages/shared/src/look/view.ts', 'cloudflare/workers/src/look/service.ts',
                     'websites/typescript/src/look-review.ts', 'scripts/deploy-look-manager.mjs',
                     'tools/governance-production/look-manager-registration.json']:
            with self.subTest(path=path):
                self.assertTrue(should_activate('push', [path]))

    def test_explicit_existing_dispatch_remains_eligible(self):
        self.assertTrue(should_activate('workflow_dispatch', []))

    def test_unknown_events_and_unsafe_paths_fail_closed(self):
        with self.assertRaises(ValueError):
            should_activate('unknown', [])
        for path in ['/cloudflare/workers/src/look/service.ts', '../look/service.ts']:
            with self.assertRaises(ValueError):
                should_activate('push', [path])
