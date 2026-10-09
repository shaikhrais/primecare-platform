#!/usr/bin/env python3
"""Separate existing platform data contracts and governance class files."""
import argparse
import json
import re
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SOURCE = '73ed61dcf5f5b047cf97a0f5e705212ed6f9359d'
TYPES = 'packages/flutter_core/lib/models/platform_types.dart'
ROLE = 'packages/flutter_core/lib/registry/platform_role.dart'
GOVERNANCE = 'packages/flutter_core/lib/models/domain_governance.dart'
SHARED = 'packages/primecare_models/lib/src/models/'
MANIFEST = ROOT / 'docs/refactoring/platform-governance-migration.json'
PARENTS = {
    'base_platform_tenant.dart': "/// Shared tenant metadata; branding remains specific to each consumer.\nabstract class BasePlatformTenant<TBranding> {\n  String get tenantId;\n  String get name;\n  TBranding get branding;\n}\n",
    'base_platform_module.dart': "/// Shared module metadata; this declaration grants no permissions.\nabstract class BasePlatformModule<TIcon, TRole, TScreen> {\n  String get moduleId;\n  String get name;\n  TIcon get icon;\n  List<TRole> get allowedRoles;\n  List<TScreen> get screens;\n}\n",
    'base_platform_application.dart': "/// Shared application metadata; role resolution stays in the consumer.\nabstract class BasePlatformApplication<TTenant, TRoleDefinition> {\n  String get appId;\n  String get name;\n  TTenant get tenant;\n  List<TRoleDefinition> get roleDefinitions;\n}\n",
    'base_platform_role_definition.dart': "/// Existing role metadata shared without navigation or authorization behavior.\nabstract class BasePlatformRoleDefinition<TRole, TModule> {\n  final TRole role;\n  final String label;\n  final List<TModule> modules;\n  final String dashboardRoute;\n\n  BasePlatformRoleDefinition({required this.role, required this.label,\n    required this.modules, required this.dashboardRoute});\n}\n",
}


def original(path):
    return subprocess.check_output(['git', 'show', SOURCE + ':' + path], cwd=ROOT, text=True)


def class_end(source, start):
    pattern = r'''"(?:\\.|[^"\\])*"|'(?:\\.|[^'\\])*'|//[^\n]*|/\*[\s\S]*?\*/|[{}]'''
    depth = 0
    for token in re.finditer(pattern, source[start:]):
        if token[0] == '{': depth += 1
        elif token[0] == '}':
            depth -= 1
            if depth == 0: return start + token.end()
    raise AssertionError('Unbalanced class')


def render():
    types = original(TYPES)
    helper_start = types.index('/// Centralized hub')
    extension_start = types.index('extension PrimeCareLabelExtension')
    enum_start = types.index('/// Primary subsystems')
    helper = types[helper_start:extension_start].rstrip() + '\n'
    shared_types = types[enum_start:helper_start] + types[extension_start:]
    outputs = {
        TYPES: "// Compatibility exports for existing platform callers.\nexport 'package:primecare_models/src/models/platform_types.dart';\nexport '../src/application/services/data_logistics_hub.dart';\n",
        ROLE: "// Compatibility export for the canonical shared role enum.\nexport 'package:primecare_models/src/models/platform_role.dart';\n",
        SHARED + 'platform_types.dart': shared_types,
        SHARED + 'platform_role.dart': original(ROLE),
        'packages/flutter_core/lib/src/application/services/data_logistics_hub.dart': "import 'package:primecare_models/src/models/scheduler_models.dart';\nimport 'package:primecare_models/src/models/dashboard_models.dart';\n\n" + helper,
        **{SHARED + name: content for name, content in PARENTS.items()},
    }
    source = original(GOVERNANCE)
    matches = list(re.finditer(r'(?m)^(?:///[^\n]*\n)*(?:abstract )?class (\w+)[^{]*\{', source))
    assert [m[1] for m in matches] == ['PlatformTenant', 'PlatformModule', 'PlatformRoleDefinition', 'PlatformApplication', 'PrimeCareTenant', '_DynamicPlatformModule']
    prefix = source[:matches[0].start()]
    prefix += "import 'package:primecare_models/primecare_models.dart' show BasePlatformTenant, BasePlatformModule, BasePlatformRoleDefinition, BasePlatformApplication;\n\n"
    directives = []
    for match in matches:
        name = match[1]
        content = source[match.start():class_end(source, match.start())]
        if name == 'PlatformTenant':
            content = content[:content.index('abstract class')] + 'abstract class PlatformTenant extends BasePlatformTenant<ThemeData> {}'
        elif name == 'PlatformModule':
            content = content[:content.index('abstract class')] + 'abstract class PlatformModule extends BasePlatformModule<IconData, PlatformRole, PrimeCareScreen> {}'
        elif name == 'PlatformApplication':
            content = content.replace('abstract class PlatformApplication {', 'abstract class PlatformApplication extends BasePlatformApplication<PlatformTenant, PlatformRoleDefinition> {')
            before = "  String get appId;\n  String get name;\n  PlatformTenant get tenant;\n\n  /// Canonical list of role definitions for this application.\n  List<PlatformRoleDefinition> get roleDefinitions;\n"
            assert before in content; content = content.replace(before, '')
        elif name == 'PlatformRoleDefinition':
            content = content.replace('class PlatformRoleDefinition {', 'class PlatformRoleDefinition extends BasePlatformRoleDefinition<PlatformRole, PlatformModule> {')
            before = "  final PlatformRole role;\n  final String label;\n  final List<PlatformModule> modules;\n  final String dashboardRoute;\n\n"
            assert before in content; content = content.replace(before, '')
            content = content.replace('required this.role,', 'required PlatformRole role,').replace('required this.modules,', 'required List<PlatformModule> modules,').replace('required this.dashboardRoute,', 'required String dashboardRoute,')
            content = content.replace('}) : label = label ?? role.displayName;', '}) : super(role: role, label: label ?? role.displayName,\n         modules: modules, dashboardRoute: dashboardRoute);')
        file_name = re.sub(r'(?<!^)(?=[A-Z])', '_', name.lstrip('_')).lower() + '.dart'
        path = 'packages/flutter_core/lib/src/domain/governance/' + file_name
        directives.append("part '../src/domain/governance/" + file_name + "';\n")
        content = '\n'.join(line.rstrip() for line in content.splitlines())
        outputs[path] = "part of '../../../models/domain_governance.dart';\n\n" + content.rstrip() + '\n'
    outputs[GOVERNANCE] = prefix + ''.join(directives)
    return outputs


def main():
    parser = argparse.ArgumentParser(); parser.add_argument('--check', action='store_true'); args = parser.parse_args()
    files = render()
    manifest = {'sourceCommit': SOURCE, 'files': list(files), 'sharedEnums': 5, 'sharedParents': 4, 'governanceClassFiles': 6, 'completedWorkflows': 0}
    if args.check:
        for path, content in files.items(): assert (ROOT / path).read_text() == content, 'Platform extraction changed: ' + path
        assert json.loads(MANIFEST.read_text()) == manifest
        print(json.dumps({key: manifest[key] for key in ['sharedEnums', 'sharedParents', 'governanceClassFiles', 'completedWorkflows']}))
    else:
        assert not MANIFEST.exists()
        for path in [TYPES, ROLE, GOVERNANCE]: assert (ROOT / path).read_text() == original(path)
        for path, content in files.items():
            target = ROOT / path; target.parent.mkdir(parents=True, exist_ok=True); target.write_text(content)
        MANIFEST.write_text(json.dumps(manifest, indent=2) + '\n')


if __name__ == '__main__': main()
