#!/usr/bin/env python3
"""Move existing Flutter-independent data models into the shared Dart package."""
import argparse
import json
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SOURCE = '04213b2d17199af8284062ef38edcd2b8c1df4fa'
MANIFEST = ROOT / 'docs/refactoring/shared-data-model-migration.json'
USER = 'packages/flutter_core/lib/providers/user_management_provider.dart'
ARTICLE = 'packages/flutter_core/lib/models/clinical_article.dart'
SHARED = 'packages/primecare_models/lib/src/models/'
GENERATED = [ARTICLE.replace('.dart', suffix) for suffix in ['.freezed.dart', '.g.dart']]


def original(path):
    return subprocess.check_output(['git', 'show', SOURCE + ':' + path], cwd=ROOT, text=True)


def render():
    source = original(USER)
    start = source.index('class UserModel {')
    end = source.index('class UserManagementNotifier')
    model = source[start:end].rstrip() + '\n'
    model = model.replace('class UserModel {', 'class UserModel extends BaseEntity<String> {').replace('  final String id;\n', '').replace('required this.id,', 'required super.id,')
    user = source[:start] + "import 'package:primecare_models/primecare_models.dart' show UserModel;\nexport 'package:primecare_models/primecare_models.dart' show UserModel;\n\n" + source[end:]
    return {
        USER: user,
        SHARED + 'user_model.dart': "import 'base_entity.dart';\n\n" + model,
        ARTICLE: "// Public compatibility export for existing Flutter imports.\nexport 'package:primecare_models/src/models/clinical_article.dart';\n",
        SHARED + 'clinical_article.dart': original(ARTICLE),
        **{SHARED + Path(path).name: original(path) for path in GENERATED},
    }


def main():
    parser = argparse.ArgumentParser(); parser.add_argument('--check', action='store_true'); args = parser.parse_args()
    files = render()
    manifest = {'sourceCommit': SOURCE, 'files': list(files), 'removedLegacyParts': GENERATED, 'models': ['UserModel', 'ClinicalArticle'], 'completedWorkflows': 0}
    if args.check:
        for path, content in files.items(): assert (ROOT / path).read_text() == content, 'Shared data model changed: ' + path
        for path in GENERATED: assert not (ROOT / path).exists(), 'Duplicate generated model: ' + path
        assert json.loads(MANIFEST.read_text()) == manifest
        print(json.dumps({'models': 2, 'sharedEntityParents': 1, 'publicImportsPreserved': True, 'completedWorkflows': 0}))
    else:
        assert not MANIFEST.exists()
        for path in [USER, ARTICLE, *GENERATED]: assert (ROOT / path).read_text() == original(path)
        for path, content in files.items():
            target = ROOT / path; target.parent.mkdir(parents=True, exist_ok=True); target.write_text(content)
        for path in GENERATED: (ROOT / path).unlink()
        MANIFEST.write_text(json.dumps(manifest, indent=2) + '\n')


if __name__ == '__main__': main()
