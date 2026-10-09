#!/usr/bin/env python3
"""Run the original and inherited contracts against the same inputs."""
import argparse
import re
import subprocess
from refactor_screen_metadata import ROOT, SCREEN, NAV, original

FIELDS = re.findall(r'  final ([^;\n]+?) (\w+);', original(SCREEN))

def run(dart, flutter=None):
    package = ROOT / ('packages/flutter_core' if flutter else 'packages/primecare_models')
    directory = package / ('lib/models' if flutter else 'test')
    baseline = directory / 'screen_metadata_parity_baseline.dart'
    nav = directory / 'navigation_parity_baseline.dart'
    runner = package / 'test/screen_metadata_parity_runner.dart'
    for path in [baseline, nav, runner]: assert not path.exists(), path
    try:
        source = original(SCREEN)
        nav_source = original(NAV)
        if not flutter:
            source = source.replace("import 'package:flutter/material.dart';", '').replace("import 'governance_types.dart';", "import 'package:primecare_models/src/models/governance_types.dart';").replace("import 'platform_geometry.dart';", "import 'package:primecare_models/src/models/platform_geometry.dart';\ntypedef IconData = String;")
            nav_source = nav_source.replace("import 'package:flutter/material.dart';", 'typedef IconData = String;')
        baseline.write_text(source); nav.write_text(nav_source)
        old_uri = 'package:flutter_core/models/screen_metadata_parity_baseline.dart' if flutter else 'screen_metadata_parity_baseline.dart'
        nav_uri = 'package:flutter_core/models/navigation_parity_baseline.dart' if flutter else 'navigation_parity_baseline.dart'
        imports = "import 'dart:convert';\nimport 'package:primecare_models/primecare_models.dart';\nimport '"+old_uri+"' as old;\nimport '"+nav_uri+"' as oldNav;\n"
        if flutter:
            imports += "import 'package:flutter/material.dart';\nimport 'package:flutter_test/flutter_test.dart';\nimport 'package:flutter_core/models/screen_metadata.dart' as current;\nimport 'package:flutter_core/models/navigation_item.dart' as currentNav;\n"
        old_class = 'old.ScreenMetadata'; new_class = 'current.ScreenMetadata' if flutter else 'BaseScreenMetadata<String>'
        new_nav = 'currentNav.PrimeCareNavigationItem' if flutter else 'BaseNavigationItem<String>'
        icon = 'Icons.home' if flutter else "'home-icon'"
        values = {}
        for kind, name in FIELDS:
            values[name] = {'String': repr('existing-' + name), 'String?': repr('existing-' + name), 'bool': 'true', 'int': '7', 'double': '0.875', 'List<String>': "<String>['existing-" + name + "']", 'PlatformSize': 'const PlatformSize(800, 600)', 'IconData?': icon, 'LifecycleStatus': 'LifecycleStatus.testing', 'PriorityLevel': 'PriorityLevel.p0', 'SecurityTier': 'SecurityTier.high', 'GovernanceCategory': 'GovernanceCategory.audit'}[kind]
        full = ', '.join(name + ': ' + value for name, value in values.items())
        access = ', '.join(repr(name) + ': normalize(value.' + name + ')' for _, name in FIELDS)
        code = imports + r'''
int cases = 0;
Object? normalize(dynamic value) {
  if (value is Enum) return value.name;
  if (value is PlatformSize) return [value.width, value.height];
  if (value is List) return value.map(normalize).toList();
  return value;
}
Object snapshot(dynamic value) => {FIELDS,
  'routePath': value.routePath, 'allowedRoles': value.allowedRoles, 'sprintPoints': value.sprintPoints,
  'role': value.role, 'canImplement': value.canImplement, 'json': value.toJson()};
void same(dynamic before, dynamic after) {
  // Icon objects share identity; JSON intentionally omits icon and design size.
  if (before.icon != after.icon) throw StateError('Icon changed');
  final left = snapshot(before) as Map; final right = snapshot(after) as Map;
  left.remove('icon'); right.remove('icon');
  if (jsonEncode(left) != jsonEncode(right)) throw StateError('Metadata changed: $left != $right');
  cases++;
}
String parsingTrace(Map<String, dynamic> input, bool useCurrent) {
  try { return jsonEncode(snapshot(useCurrent ? NEW.fromJson(input) : OLD.fromJson(input))); }
  catch (error) {return error.runtimeType.toString();}
}
void verify() {
  final before = OLD(FULL); final after = NEW(FULL);
  same(before, after);
  same(OLD(id: 'x', title: 'Existing'), NEW(id: 'x', title: 'Existing'));
  same(OLD(id: 'x', title: 'Existing', route: '/original', routePath: '/alias', roles: ['original'], allowedRoles: ['alias'], designSizeValue: 'ignored'),
       NEW(id: 'x', title: 'Existing', route: '/original', routePath: '/alias', roles: ['original'], allowedRoles: ['alias'], designSizeValue: 'ignored'));
  same(before.copyWith(), after.copyWith());
  if (after is! BaseScreenMetadata || after is! BaseEntity<String> || after.copyWith() is! NEW || NEW.fromJson(after.toJson()) is! NEW) throw StateError('Inheritance or subtype changed');
  same(before.copyWith(icon: null), after.copyWith(icon: null));
  COPIES
  final json = before.toJson() as Map<String, dynamic>;
  same(OLD.fromJson(json), NEW.fromJson(json));
  for (final entry in json.entries) {
    for (final value in [null, true, false, 0, 1.25, '', 'unknown-enum', <Object>[], <String, dynamic>{}]) {
      final input = Map<String, dynamic>.from(json)..[entry.key] = value;
      if (parsingTrace(input, false) != parsingTrace(input, true)) throw StateError('JSON behavior changed: ${entry.key}=$value');
      cases++;
    }
    final input = Map<String, dynamic>.from(json)..remove(entry.key);
    if (parsingTrace(input, false) != parsingTrace(input, true)) throw StateError('Missing field behavior changed: ${entry.key}');
    cases++;
  }
  for (final status in LifecycleStatus.values) {
    for (final audit in [false, true]) same(OLD(id:'x', title:'Existing', lifecycleStatus:status, isAuditCompliant:audit), NEW(id:'x', title:'Existing', lifecycleStatus:status, isAuditCompliant:audit));
  }
  final roles = <String>['original'];
  final borrowed = NEW(id:'x', title:'Existing', roles:roles);
  if (!identical(borrowed.roles, roles) || !identical(borrowed.copyWith().roles, roles)) throw StateError('List ownership changed');
  roles.add('later'); if (borrowed.allowedRoles.length != 2) throw StateError('List mutation changed');
  cases++;
  for (final section in [null, '', 'section']) {
    final beforeNav = oldNav.PrimeCareNavigationItem(label:'Existing', icon:ICON, route:'/existing', section:section, activeIcon:ICON);
    final afterNav = NEWNAV(label:'Existing', icon:ICON, route:'/existing', section:section, activeIcon:ICON);
    if (beforeNav.label != afterNav.label || beforeNav.icon != afterNav.icon || beforeNav.route != afterNav.route || beforeNav.section != afterNav.section || beforeNav.activeIcon != afterNav.activeIcon) throw StateError('Navigation changed');
    cases++;
  }
  print('Screen metadata parity passed: $cases cases');
}
MAIN
'''
        copy_values = {name: value.replace('existing-', 'override-').replace('true', 'false').replace('0.875', '0.25').replace('800, 600', '320, 240').replace('LifecycleStatus.testing', 'LifecycleStatus.legacy').replace('PriorityLevel.p0', 'PriorityLevel.p3').replace('SecurityTier.high', 'SecurityTier.low').replace('Icons.home', 'Icons.settings').replace('home-icon', 'settings-icon') for name, value in values.items()}
        copy_values.update(testScenarioCount='9', complexity='9', storyPoints='9')
        copies = '\n'.join('  same(before.copyWith('+name+': '+value+'), after.copyWith('+name+': '+value+'));' for name, value in copy_values.items())
        # Replace whole marker tokens without changing identifiers.
        replacements = {'FIELDS':access, 'NEW':new_class, 'OLD':old_class, 'FULL':full, 'COPIES':copies, 'ICON':icon, 'NEWNAV':new_nav, 'MAIN':"void main() { test('original screen and navigation contracts remain compatible', verify); }" if flutter else 'void main() => verify();'}
        code = re.sub(r'\b('+'|'.join(replacements)+r')\b', lambda m: replacements[m[0]], code)
        runner.write_text(code)
        subprocess.run([flutter or dart, 'test' if flutter else 'run', str(runner.relative_to(package))], cwd=package, check=True)
    finally:
        for path in [baseline, nav, runner]: path.unlink(missing_ok=True)

def main():
    parser=argparse.ArgumentParser(); parser.add_argument('--dart', default='dart'); parser.add_argument('--flutter'); args=parser.parse_args()
    run(args.dart)
    if args.flutter: run(args.dart, args.flutter)
if __name__ == '__main__': main()
