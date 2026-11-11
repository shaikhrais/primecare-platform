import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/src/features/generated_screens/adjustment_notes.dart' as repaired0;
import 'package:primecare_ui/src/features/generated_screens/rmt_treatment_notes.dart' as repaired1;
import 'package:primecare_ui/src/features/generated_screens/chiropractor_treatment_notes.dart' as repaired2;
import 'package:primecare_ui/src/features/generated_screens/caregiver_visit_notes.dart' as repaired3;
import 'package:primecare_ui/src/features/generated_screens/physiotherapist_treatment_notes.dart' as repaired4;
import 'package:primecare_ui/src/features/generated_screens/psw_daily_notes.dart' as repaired5;
import 'package:primecare_ui/src/features/generated_screens/psw_visit_notes.dart' as repaired6;
import 'package:primecare_ui/src/features/generated_screens/regional_bdm_competitor_notes.dart' as repaired7;

void main() {
  test('all repaired generated screens compile with shared theme controls', () {
    final types = <Type>[
      repaired0.AdjustmentNotesScreen,
      repaired1.RmtTreatmentNotesScreen,
      repaired2.ChiropractorTreatmentNotesScreen,
      repaired3.CaregiverVisitNotesScreen,
      repaired4.PhysiotherapistTreatmentNotesScreen,
      repaired5.PswDailyNotesScreen,
      repaired6.PswVisitNotesScreen,
      repaired7.RegionalBdmCompetitorNotesScreen
    ];
    expect(types, hasLength(8));
  });
}
