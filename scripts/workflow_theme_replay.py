"""Replay reviewed theme migrations; never replace historical contract hashes."""
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import subprocess

PROOF = 'docs/api/workflow-contract-theme-replay.json'
BASELINE = '4e6195c51e639e362b2884e4de435578960f0983'
MIGRATIONS = frozenset(('branding-settings-palette', 'clinical-semantic-palette',
    'core-shared-primitives', 'generated-palette-closure', 'premium-compliance-badges',
    'premium-compliance-headers', 'premium-health-colors', 'premium-health-layout',
    'premium-primary-brand', 'premium-progress', 'premium-semantic-accents',
    'premium-surfaces', 'premium-telemetry-rows', 'premium-trend-colors',
    'premium-trend-labels', 'remaining-theme-palette', 'shared-cards', 'shared-status'))


DEPENDENCIES = frozenset(('scripts/branding-settings-palette-manifest.json', 'scripts/check-shared-ui-boundary.py', 'scripts/clean-shared-status-imports.py', 'scripts/clinical-semantic-palette-manifest.json', 'scripts/core-shared-primitives-manifest.json', 'scripts/generated-palette-closure-manifest.json', 'scripts/migrate-branding-settings-palette.py', 'scripts/migrate-clinical-semantic-palette.py', 'scripts/migrate-core-shared-primitives.py', 'scripts/migrate-generated-palette-closure.py', 'scripts/migrate-generated-theme.py', 'scripts/migrate-premium-compliance-badges.py', 'scripts/migrate-premium-compliance-headers.py', 'scripts/migrate-premium-health-colors.py', 'scripts/migrate-premium-health-layout.py', 'scripts/migrate-premium-primary-brand.py', 'scripts/migrate-premium-progress.py', 'scripts/migrate-premium-semantic-accents.py', 'scripts/migrate-premium-surfaces.py', 'scripts/migrate-premium-telemetry-rows.py', 'scripts/migrate-premium-trend-colors.py', 'scripts/migrate-premium-trend-labels.py', 'scripts/migrate-remaining-theme-palette.py', 'scripts/migrate-shared-buttons.py', 'scripts/migrate-shared-cards.py', 'scripts/migrate-shared-icons.py', 'scripts/migrate-shared-status.py', 'scripts/migrate-shared-text.py', 'scripts/remaining-theme-palette-manifest.json'))


def digest(content):
    return hashlib.sha256(content).hexdigest()


def local_file(root, filename):
    path = Path(filename)
    if (not isinstance(filename, str) or not filename or path.is_absolute()
            or '..' in path.parts or path.as_posix() != filename):
        raise ValueError('Invalid theme replay path')
    target = root / path
    if target.is_symlink() or not target.resolve().is_relative_to(root) or not target.is_file():
        raise ValueError('Theme replay source missing or escapes repository: ' + filename)
    return target


class WorkflowThemeReplay:
    def __init__(self, root, historical_hashes):
        self.root = Path(root).resolve()
        self.hashes = historical_hashes
        self.doc = json.loads(local_file(self.root, PROOF).read_text())
        doc = self.doc
        keys = {'version', 'noActivation', 'implementationCredits', 'retirementCredits',
                'baselineCommit', 'scope', 'dependencies', 'pipelines', 'recipes'}
        if (not isinstance(doc, dict) or set(doc) != keys or type(doc['version']) is not int
                or doc['version'] != 1 or doc['noActivation'] is not True
                or any(type(doc[k]) is not int or doc[k] != 0 for k in ('implementationCredits', 'retirementCredits'))
                or doc['baselineCommit'] != BASELINE or not isinstance(doc['scope'], str) or not doc['scope'].strip()
                or any(not isinstance(doc[k], dict) or not doc[k] for k in ('dependencies', 'pipelines', 'recipes'))):
            raise ValueError('Invalid nonactivating theme replay proof')
        if set(doc['dependencies']) != DEPENDENCIES:
            raise ValueError('Incomplete reviewed theme replay dependencies')
        self.recipes = doc['recipes']
        for filename, expected in doc['dependencies'].items():
            if (not filename.startswith('scripts/') or not re.fullmatch('[0-9a-f]{64}', str(expected))
                    or digest(local_file(self.root, filename).read_bytes()) != expected):
                raise ValueError('Reviewed theme replay dependency changed: ' + filename)
        for steps in doc['pipelines'].values():
            if not isinstance(steps, list) or not steps:
                raise ValueError('Empty theme replay pipeline')
            for step in steps:
                if not isinstance(step, list) or len(step) != 3:
                    raise ValueError('Invalid theme replay step')
                name, method, count = step
                allowed = {'migrate-' + n + '.py' for n in MIGRATIONS}
                if (name not in allowed or method not in ('migrate', 'migrate_source')
                        or (method == 'migrate_source' and name != 'migrate-shared-cards.py')
                        or type(count) is not int or count <= 0 or 'scripts/' + name not in doc['dependencies']):
                    raise ValueError('Unreviewed theme replay step')
        for filename, pipeline in self.recipes.items():
            if filename not in historical_hashes or pipeline not in doc['pipelines']:
                raise ValueError('Unpinned theme replay source: ' + filename)
            local_file(self.root, filename)
        self.modules = {}

    def historical(self, filename):
        try:
            return subprocess.run(['git', 'show', BASELINE + ':' + filename], cwd=self.root,
                check=True, capture_output=True, timeout=15).stdout
        except (subprocess.CalledProcessError, subprocess.TimeoutExpired) as error:
            raise ValueError('Immutable theme replay source unavailable; fetch ' + BASELINE) from error

    def verify(self, filename, content):
        if filename not in self.recipes:
            raise ValueError('Unreviewed theme replay source: ' + filename)
        original = self.historical(filename)
        if digest(original) != self.hashes[filename]:
            raise ValueError('Theme replay historical source hash mismatch: ' + filename)
        source = original.decode('utf-8')
        for name, method, expected in self.doc['pipelines'][self.recipes[filename]]:
            if name not in self.modules:
                path = local_file(self.root, 'scripts/' + name)
                spec = importlib.util.spec_from_file_location('contract_replay_' + name.replace('-', '_'), path)
                module = importlib.util.module_from_spec(spec)
                spec.loader.exec_module(module)
                self.modules[name] = module
            migrate = getattr(self.modules[name], method)
            source, count = migrate(filename, source) if method == 'migrate_source' else migrate(source)
            if count != expected:
                raise ValueError('Reviewed theme replay operation count changed: ' + filename + ' / ' + name)
        if source.encode('utf-8') != content:
            raise ValueError('Source exceeds exact reviewed theme replay: ' + filename)
