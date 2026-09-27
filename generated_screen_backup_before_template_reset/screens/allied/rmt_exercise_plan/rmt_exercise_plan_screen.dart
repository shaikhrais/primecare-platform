import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rmt_exercise_plan_header_section.dart';
import 'sections/rmt_exercise_plan_content_summary_section.dart';
import 'sections/rmt_exercise_plan_primary_content_section.dart';
import 'sections/rmt_exercise_plan_action_bar_section.dart';

class RmtExercisePlanScreen extends StatelessWidget {
  const RmtExercisePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rmt_exercise_plan',
      title: 'RmtExercisePlanScreen',
      child: Column(
        children: const [
          const RmtExercisePlanHeaderSection(),
          const RmtExercisePlanContentSummarySection(),
          const RmtExercisePlanPrimaryContentSection(),
          const RmtExercisePlanActionBarSection(),
        ],
      ),
    );
  }
}
