import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/theme/prime_semantic_palette.dart';

void main() {
 test('shared UI exposes its actual status roles to core without changing material override identity', () {
  const colors=PrimeColors(success:Colors.pink,successContainer:Colors.black,warning:Colors.cyan,warningContainer:Colors.white);
  final material=const PrimeThemeData(colors:colors).toThemeData();
  final tokens=material.extension<PrimeSemanticStatusColors>()!;
  expect(tokens.success,colors.success);expect(tokens.successContainer,colors.successContainer);
  expect(tokens.warning,colors.warning);expect(tokens.warningContainer,colors.warningContainer);
  expect(PrimeThemeData(materialTheme:material).toThemeData(),same(material));
  expect(tokens.copyWith(success:Colors.green).warning,colors.warning);
  expect(tokens.lerp(tokens,0.5).success,colors.success);
 });
}
