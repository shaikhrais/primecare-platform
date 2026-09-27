import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/physiotherapist_exercise_plan_header_section.dart';
import 'sections/physiotherapist_exercise_plan_content_summary_section.dart';
import 'sections/physiotherapist_exercise_plan_primary_content_section.dart';
import 'sections/physiotherapist_exercise_plan_action_bar_section.dart';

class PhysiotherapistExercisePlanScreen extends StatelessWidget {
  const PhysiotherapistExercisePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'physiotherapist_exercise_plan',
      title: 'PhysiotherapistExercisePlanScreen',
      child: Column(
        children: const [
          const PhysiotherapistExercisePlanHeaderSection(),
          const PhysiotherapistExercisePlanContentSummarySection(),
          const PhysiotherapistExercisePlanPrimaryContentSection(),
          const PhysiotherapistExercisePlanActionBarSection(),
        ],
      ),
    );
  }
}
