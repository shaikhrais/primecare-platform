import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/exercise_prescription_header_section.dart';
import 'sections/exercise_prescription_content_summary_section.dart';
import 'sections/exercise_prescription_primary_content_section.dart';
import 'sections/exercise_prescription_action_bar_section.dart';

class ExercisePrescriptionScreen extends StatelessWidget {
  const ExercisePrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'exercise_prescription',
      title: 'ExercisePrescriptionScreen',
      child: Column(
        children: const [
          const ExercisePrescriptionHeaderSection(),
          const ExercisePrescriptionContentSummarySection(),
          const ExercisePrescriptionPrimaryContentSection(),
          const ExercisePrescriptionActionBarSection(),
        ],
      ),
    );
  }
}
