import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/src/features/generated_screens/adjustment_notes.dart' as adjustment;
import 'package:primecare_ui/src/features/generated_screens/rmt_treatment_notes.dart' as rmt;
import 'package:primecare_ui/src/features/generated_screens/chiropractor_treatment_notes.dart' as chiropractor;

void main() {
  test('repaired generated screens compile against the shared UI and theme', () {
    final types = <Type>[adjustment.AdjustmentNotesScreen,
      rmt.RmtTreatmentNotesScreen, chiropractor.ChiropractorTreatmentNotesScreen];
    expect(types, hasLength(3));
  });
}
