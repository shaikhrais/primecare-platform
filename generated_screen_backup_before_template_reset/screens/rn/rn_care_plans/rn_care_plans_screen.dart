import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rn_care_plans_header_section.dart';
import 'sections/rn_care_plans_content_summary_section.dart';
import 'sections/rn_care_plans_primary_content_section.dart';
import 'sections/rn_care_plans_action_bar_section.dart';

class RnCarePlansScreen extends StatelessWidget {
  const RnCarePlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rn_care_plans',
      title: 'RnCarePlansScreen',
      child: Column(
        children: const [
          const RnCarePlansHeaderSection(),
          const RnCarePlansContentSummarySection(),
          const RnCarePlansPrimaryContentSection(),
          const RnCarePlansActionBarSection(),
        ],
      ),
    );
  }
}
