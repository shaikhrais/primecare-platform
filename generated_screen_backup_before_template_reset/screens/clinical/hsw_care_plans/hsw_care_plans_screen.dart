import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hsw_care_plans_header_section.dart';
import 'sections/hsw_care_plans_content_summary_section.dart';
import 'sections/hsw_care_plans_primary_content_section.dart';
import 'sections/hsw_care_plans_action_bar_section.dart';

class HswCarePlansScreen extends StatelessWidget {
  const HswCarePlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hsw_care_plans',
      title: 'HswCarePlansScreen',
      child: Column(
        children: const [
          const HswCarePlansHeaderSection(),
          const HswCarePlansContentSummarySection(),
          const HswCarePlansPrimaryContentSection(),
          const HswCarePlansActionBarSection(),
        ],
      ),
    );
  }
}
