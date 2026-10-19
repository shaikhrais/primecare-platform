#!/usr/bin/env python3
"""Reproduce shared screen/navigation contracts from the pinned original."""
import argparse
import json
import re
import subprocess
from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]
SOURCE = '6e11e02852785a3aa55430b978b193bae75147e5'
SCREEN = 'packages/flutter_core/lib/models/screen_metadata.dart'
NAV = 'packages/flutter_core/lib/models/navigation_item.dart'
DEST = 'packages/primecare_models/lib/src/models/'
MANIFEST = ROOT / 'docs/refactoring/screen-metadata-migration.json'
def original(path):
    return subprocess.check_output(['git', 'show', SOURCE + ':' + path], cwd=ROOT, text=True)
def render():
    source = original(SCREEN)
    body = source[source.index('/// [ScreenMetadata]'):]
    shared = body.replace('class ScreenMetadata {', 'class BaseScreenMetadata<TIcon> extends BaseEntity<String> {').replace('  final String id;\n', '').replace('required this.id,', 'required super.id,').replace('IconData', 'TIcon')
    shared = shared.replace('const ScreenMetadata(', 'const BaseScreenMetadata(').replace('ScreenMetadata copyWith(', 'BaseScreenMetadata<TIcon> copyWith(').replace('return ScreenMetadata(', 'return BaseScreenMetadata<TIcon>(').replace('factory ScreenMetadata.fromJson(', 'factory BaseScreenMetadata.fromJson(')
    shared = "import 'base_entity.dart';\nimport 'governance_types.dart';\nimport 'platform_geometry.dart';\n\n" + shared
    ctor_start = body.index('  const ScreenMetadata(')
    ctor_end = body.index('  /// Compatibility aliases')
    constructor = body[ctor_start:ctor_end]
    constructor = constructor[:constructor.index('  })')] + '  });\n\n'
    constructor = constructor.replace('this.', 'super.')
    constructor = re.sub(r'(?m)^(    super\.\w+) = [^\n]+,', r'\1,', constructor)
    for name in ['route', 'routePath', 'roles', 'allowedRoles', 'designSizeValue']:
        constructor = re.sub(r'(?:String\?|List<String>\?|dynamic) ' + name + r'(?=,)', 'super.' + name, constructor)
    methods = body[body.index('  ScreenMetadata copyWith('):]
    json_start = methods.index('  Map<String, dynamic> toJson()')
    json_end = methods.index('  factory ScreenMetadata.fromJson(')
    methods = methods[:json_start] + methods[json_end:]
    adapter = "// Flutter icon adapter for the shared screen metadata contract.\nimport 'package:flutter/material.dart';\nimport 'package:primecare_models/primecare_models.dart' show BaseScreenMetadata;\nimport 'governance_types.dart';\nimport 'platform_geometry.dart';\n\nclass ScreenMetadata extends BaseScreenMetadata<IconData> {\n" + constructor + '  @override\n' + methods
    nav = original(NAV)
    nav_body = nav[nav.index('class PrimeCareNavigationItem'):]
    nav_shared = nav_body.replace('class PrimeCareNavigationItem {', 'class BaseNavigationItem<TIcon> {').replace('IconData', 'TIcon').replace('const PrimeCareNavigationItem(', 'const BaseNavigationItem(')
    nav_ctor = nav_body[nav_body.index('  const PrimeCareNavigationItem('):].replace('this.', 'super.')
    nav_adapter = "// Flutter icon adapter for the shared navigation contract.\nimport 'package:flutter/material.dart';\nimport 'package:primecare_models/primecare_models.dart' show BaseNavigationItem;\n\nclass PrimeCareNavigationItem extends BaseNavigationItem<IconData> {\n" + nav_ctor
    return {SCREEN: adapter, NAV: nav_adapter, DEST + 'base_screen_metadata.dart': shared.rstrip() + '\n', DEST + 'base_navigation_item.dart': nav_shared}
def main():
    parser = argparse.ArgumentParser(); parser.add_argument('--check', action='store_true'); args = parser.parse_args()
    files = render()
    manifest = {'sourceCommit': SOURCE, 'files': list(files), 'sharedContracts': 2, 'flutterAdapters': 2, 'completedWorkflows': 0}
    if args.check:
        for path, content in files.items(): assert (ROOT / path).read_text() == content, path
        assert json.loads(MANIFEST.read_text()) == manifest
        print(json.dumps(manifest))
    else:
        assert not MANIFEST.exists()
        for path in [SCREEN, NAV]: assert (ROOT / path).read_text() == original(path)
        for path, content in files.items(): (ROOT / path).write_text(content)
        MANIFEST.write_text(json.dumps(manifest, indent=2) + '\n')
if __name__ == '__main__': main()
