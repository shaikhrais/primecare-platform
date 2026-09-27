import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_care_plan_header_section.dart';
import 'sections/psw_care_plan_content_summary_section.dart';
import 'sections/psw_care_plan_primary_content_section.dart';
import 'sections/psw_care_plan_action_bar_section.dart';

class PswCarePlanScreen extends StatelessWidget {
  const PswCarePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_care_plan',
      title: 'Psw Care Plan',
      child: Column(
        children: const [
          const PswCarePlanHeaderSection(),
          const PswCarePlanContentSummarySection(),
          const PswCarePlanPrimaryContentSection(),
          const PswCarePlanActionBarSection(),
        ],
      ),
    );
  }
}
