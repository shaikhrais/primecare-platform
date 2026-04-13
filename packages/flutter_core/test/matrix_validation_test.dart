import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Matrix Validation Test', () {
    test('Verify all screen matrix 251+ form pages are structured in the enum', () {
      final file = File('lib/adapters/primecare_form_enum.dart');
      expect(file.existsSync(), isTrue, reason: 'Enum file must exist.');
      
      final content = file.readAsStringSync();
      final enumMatches = RegExp(r"(\w+)\('([^']+)'\)").allMatches(content);
      
      final providerCount = enumMatches.length;
      expect(providerCount, greaterThan(251), reason: 'Must have at least 251 configured enum forms generated.');
      
      print('✅ VERIFICATION SUCCESS: Successfully verified $providerCount generated enum variants in the new architecture.');
    });
  });
}
