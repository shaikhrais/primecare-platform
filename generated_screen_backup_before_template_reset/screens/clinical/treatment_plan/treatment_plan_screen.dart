import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/treatment_plan_header_section.dart';
import 'sections/treatment_plan_content_summary_section.dart';
import 'sections/treatment_plan_primary_content_section.dart';
import 'sections/treatment_plan_action_bar_section.dart';

class TreatmentPlanScreen extends StatelessWidget {
  const TreatmentPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'treatment_plan',
      title: 'TreatmentPlanScreen',
      child: Column(
        children: const [
          const TreatmentPlanHeaderSection(),
          const TreatmentPlanContentSummarySection(),
          const TreatmentPlanPrimaryContentSection(),
          const TreatmentPlanActionBarSection(),
        ],
      ),
    );
  }
}
