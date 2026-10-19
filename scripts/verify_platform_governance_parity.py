#!/usr/bin/env python3
"""Compare moved platform roles and governance behavior with pinned source."""
import argparse
import re
import subprocess
from pathlib import Path
from refactor_platform_governance import ROOT, ROLE, TYPES, GOVERNANCE, original


def main():
    parser = argparse.ArgumentParser(); parser.add_argument('--dart', default='dart'); parser.add_argument('--flutter'); args = parser.parse_args()
    models = ROOT / 'packages/primecare_models'
    old_role = models / 'test/platform_role_parity_baseline.dart'
    old_types = models / 'test/platform_types_parity_baseline.dart'
    runner = models / 'test/platform_contract_parity_runner.dart'
    old_helper = models / 'test/platform_helper_parity_baseline.dart'
    paths = [old_role, old_types, runner, old_helper]
    for path in paths: assert not path.exists()
    try:
        old_role.write_text(original(ROLE))
        source = original(TYPES)
        start = source.index('/// Primary subsystems'); end = source.index('/// Centralized hub'); extension = source.index('extension PrimeCareLabelExtension')
        old_types.write_text(source[start:end] + source[extension:])
        helper_start = source.index('/// Centralized hub')
        old_helper.write_text("import 'package:primecare_models/primecare_models.dart';\n" + source[helper_start:extension])
        aliases = sorted(set(re.findall(r"normalized == '([^']+)'", original(ROLE))))
        runner.write_text(r'''import 'package:primecare_models/primecare_models.dart';
import 'platform_role_parity_baseline.dart' as before;
import 'platform_types_parity_baseline.dart' as types;
import 'platform_helper_parity_baseline.dart' as oldHelper;
import 'HELPER_URI' as helper;
import 'dart:convert';

Future<void> main() async {
  var cases = 0;
  final oldRoles = before.PlatformRole.values;
  if (oldRoles.length != PlatformRole.values.length) throw StateError('Role count changed');
  final inputs = <String?>[null, '', ' unknown-input ', ALIASES];
  for (var i = 0; i < oldRoles.length; i++) {
    final old = oldRoles[i]; final next = PlatformRole.values[i];
    if (old.name != next.name || old.index != next.index || old.nameSnake != next.nameSnake || old.displayName != next.displayName) throw StateError('Role data changed');
    cases++;
    inputs.addAll([old.name, old.name.toUpperCase(), old.nameSnake, '  ${old.nameSnake}  ', '"${old.name}"', "'${old.nameSnake}'", "\"'${old.name}'\""]);
    for (final path in ['/roles/${old.nameSnake}/existing', '/clinical/${old.nameSnake}/', '/portal/${old.nameSnake}/', '/missing']) {
      if (before.PlatformRole.fromRoute(path).name != PlatformRole.fromRoute(path).name) throw StateError('Route role mapping changed: $path');
      cases++;
    }
  }
  for (final input in inputs) {
    if (before.PlatformRole.fromName(input).name != PlatformRole.fromName(input).name) throw StateError('Role parsing changed: $input');
    cases++;
  }
  for (final pair in <List<List<String>>>[
    [types.PlatformSubsystem.values.map((e)=>e.name).toList(), PlatformSubsystem.values.map((e)=>e.name).toList()],
    [types.AppShellType.values.map((e)=>e.name).toList(), AppShellType.values.map((e)=>e.name).toList()],
    [types.PrimeCareForm.values.map((e)=>e.name).toList(), PrimeCareForm.values.map((e)=>e.name).toList()],
    [types.PrimeCareLabel.values.map((e)=>e.name).toList(), PrimeCareLabel.values.map((e)=>e.name).toList()],
  ]) {
    if (pair[0].join('|') != pair[1].join('|')) throw StateError('Enum ordering changed');
    cases++;
  }
  for (var i = 0; i < PrimeCareLabel.values.length; i++) {
    for (final language in ['en', 'fr', 'unknown']) {
      if (types.PrimeCareLabelExtension(types.PrimeCareLabel.values[i]).get(language) != PrimeCareLabel.values[i].get(language)) throw StateError('Label behavior changed');
      cases++;
    }
  }
  for (final fail in [false, true]) {
    for (final callbackFails in [false, true]) {
      final traces = <Object>[];
      for (final current in [false, true]) {
        final events = <String>[];
        final function = current ? helper.DataLogisticsHub.fetchAndAssemble<String> : oldHelper.DataLogisticsHub.fetchAndAssemble<String>;
        try {
          final result = await function('existing-operation', fetchCall: () async {
            events.add('fetch'); if (fail) throw StateError('fetch failed'); return 'original';
          }, fallbackBuilder: () {events.add('fallback'); return 'fallback';},
          assembler: (_) {events.add('assembler'); return 'assembled';},
          onError: (error, stack) {events.add(error.toString()); if (callbackFails) throw StateError('callback failed');});
          traces.add([result, events]);
        } catch (error) {traces.add([error.toString(), events]);}
      }
      if (jsonEncode(traces[0]) != jsonEncode(traces[1])) throw StateError('Fallback behavior changed');
      cases++;
    }
  }
  for (final report in ['revenue_log', 'unknown']) {
    if (jsonEncode(helper.DataLogisticsHub.getReportBlueprint(report)) != jsonEncode(oldHelper.DataLogisticsHub.getReportBlueprint(report))) throw StateError('Report blueprint changed');
    cases++;
  }
  print('Platform contract parity passed: $cases role/route/enum/label/fallback cases');
}
'''.replace('ALIASES', ', '.join(repr(alias) for alias in aliases)).replace('HELPER_URI', (ROOT / 'packages/flutter_core/lib/src/application/services/data_logistics_hub.dart').as_uri()))
        subprocess.run([args.dart, 'run', str(runner.relative_to(models))], cwd=models, check=True)
    finally:
        for path in paths: path.unlink(missing_ok=True)
    if args.flutter:
        verify_flutter(args.flutter)


def verify_flutter(flutter):
    core = ROOT / 'packages/flutter_core'
    baseline = core / 'lib/models/domain_governance_parity_baseline.dart'
    runner = core / 'test/platform_governance_parity_runner.dart'
    assert not baseline.exists() and not runner.exists()
    try:
        baseline.write_text(original(GOVERNANCE))
        runner.write_text(r'''import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/models/domain_governance.dart' as current;
import 'package:flutter_core/models/domain_governance_parity_baseline.dart' as old;
import 'package:flutter_core/models/screen.dart';
import 'package:flutter_core/registry/platform_role.dart';
import 'package:primecare_models/primecare_models.dart' as shared;

class CurrentApplication extends current.PlatformApplication {
  @override String get appId => 'existing-app';
  @override String get name => 'Existing';
  @override final current.PlatformTenant tenant = current.PrimeCareTenant();
  @override final List<current.PlatformRoleDefinition> roleDefinitions;
  CurrentApplication(this.roleDefinitions);
}
class OldApplication extends old.PlatformApplication {
  @override String get appId => 'existing-app';
  @override String get name => 'Existing';
  @override final old.PlatformTenant tenant = old.PrimeCareTenant();
  @override final List<old.PlatformRoleDefinition> roleDefinitions;
  OldApplication(this.roleDefinitions);
}
class CurrentModule extends current.PlatformModule {
  @override String get moduleId => 'existing-module';
  @override String get name => 'Existing';
  @override IconData get icon => Icons.home;
  @override List<PlatformRole> get allowedRoles => [PlatformRole.client];
  @override final List<PrimeCareScreen> screens;
  CurrentModule(this.screens);
}
class OldModule extends old.PlatformModule {
  @override String get moduleId => 'existing-module';
  @override String get name => 'Existing';
  @override IconData get icon => Icons.home;
  @override List<PlatformRole> get allowedRoles => [PlatformRole.client];
  @override final List<PrimeCareScreen> screens;
  OldModule(this.screens);
}
Object moduleTrace(dynamic module) => [module.moduleId, module.name, module.icon.codePoint,
  [for (final dynamic role in module.allowedRoles) (role as PlatformRole).name],
  [for (final dynamic screen in module.screens) [screen.title, screen.route, (screen.requiredRole as PlatformRole).name, screen.icon?.codePoint]]];
Object definitionTrace(dynamic definition) => definition == null ? [] : [(definition.role as PlatformRole).name, definition.label, definition.dashboardRoute,
  [for (final dynamic module in definition.modules) moduleTrace(module)],
  [for (final dynamic item in definition.navigationItems) [item.label, item.route, item.icon.codePoint]]];

void main() {
  test('governance role, navigation and dynamic fallback behavior remain identical', () {
    final screens = [PrimeCareScreen(title: 'Existing', route: '/existing', requiredRole: PlatformRole.client),
      PrimeCareScreen(title: 'Guest', route: '/guest', requiredRole: PlatformRole.guest)];
    final oldModules = <old.PlatformModule>[OldModule(screens)];
    final newModules = <current.PlatformModule>[CurrentModule(screens)];
    final beforeDefinition = old.PlatformRoleDefinition(role: PlatformRole.client, modules: oldModules, dashboardRoute: '/existing');
    final afterDefinition = current.PlatformRoleDefinition(role: PlatformRole.client, modules: newModules, dashboardRoute: '/existing');
    expect(afterDefinition, isA<shared.BasePlatformRoleDefinition<PlatformRole, current.PlatformModule>>());
    expect(afterDefinition.modules, same(newModules));
    expect(jsonEncode(definitionTrace(beforeDefinition)), jsonEncode(definitionTrace(afterDefinition)));
    for (final populated in [false, true]) {
      final before = OldApplication(populated ? [beforeDefinition] : []);
      final after = CurrentApplication(populated ? [afterDefinition] : []);
      expect(after, isA<shared.BasePlatformApplication<current.PlatformTenant, current.PlatformRoleDefinition>>());
      expect(after.tenant, isA<shared.BasePlatformTenant<ThemeData>>());
      for (final role in PlatformRole.values) {
        expect(jsonEncode(definitionTrace(before.getDefinition(role))), jsonEncode(definitionTrace(after.getDefinition(role))), reason: 'definition ${role.name} populated=$populated');
        expect(jsonEncode([for (final module in before.getAuthorizedModules(role)) moduleTrace(module)]), jsonEncode([for (final module in after.getAuthorizedModules(role)) moduleTrace(module)]), reason: 'modules ${role.name} populated=$populated');
      }
    }
    expect(beforeDefinition.navigationItems.length, 1);
    expect(afterDefinition.navigationItems.length, 1);
    newModules.add(CurrentModule([])); oldModules.add(OldModule([]));
    expect(jsonEncode(definitionTrace(beforeDefinition)), jsonEncode(definitionTrace(afterDefinition)));
  });
}
''')
        subprocess.run([flutter, 'test', str(runner.relative_to(core))], cwd=core, check=True)
    finally:
        baseline.unlink(missing_ok=True); runner.unlink(missing_ok=True)


if __name__ == '__main__': main()
