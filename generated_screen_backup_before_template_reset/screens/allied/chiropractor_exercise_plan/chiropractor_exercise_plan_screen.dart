import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/chiropractor_exercise_plan_header_section.dart';
import 'sections/chiropractor_exercise_plan_content_summary_section.dart';
import 'sections/chiropractor_exercise_plan_primary_content_section.dart';
import 'sections/chiropractor_exercise_plan_action_bar_section.dart';

class ChiropractorExercisePlanScreen extends StatelessWidget {
  const ChiropractorExercisePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'chiropractor_exercise_plan',
      title: 'ChiropractorExercisePlanScreen',
      child: Column(
        children: const [
          const ChiropractorExercisePlanHeaderSection(),
          const ChiropractorExercisePlanContentSummarySection(),
          const ChiropractorExercisePlanPrimaryContentSection(),
          const ChiropractorExercisePlanActionBarSection(),
        ],
      ),
    );
  }
}
