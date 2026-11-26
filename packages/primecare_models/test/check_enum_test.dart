import 'dart:async';
import 'package:primecare_models/diagnostics/check_enum.dart' as diagnostic;
import 'package:primecare_models/src/models/platform_role.dart';
import 'package:test/test.dart';

void main() {
  test('diagnostic lists each canonical role once', () {
    final lines = <String>[];
    runZoned(diagnostic.main, zoneSpecification: ZoneSpecification(
      print: (_, _, _, line) => lines.add(line),
    ));
    expect(lines, ['PlatformRole values:', ...PlatformRole.values.map(
      (role) => '  ${role} -> name: ${role.name}, nameSnake: ${role.nameSnake}',
    )]);
  });
}
