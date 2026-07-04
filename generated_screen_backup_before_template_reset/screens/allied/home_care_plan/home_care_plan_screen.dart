import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/home_care_plan_header_section.dart';
import 'sections/home_care_plan_content_summary_section.dart';
import 'sections/home_care_plan_primary_content_section.dart';
import 'sections/home_care_plan_action_bar_section.dart';

class HomeCarePlanScreen extends StatelessWidget {
  const HomeCarePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'home_care_plan',
      title: 'HomeCarePlanScreen',
      child: Column(
        children: const [
          const HomeCarePlanHeaderSection(),
          const HomeCarePlanContentSummarySection(),
          const HomeCarePlanPrimaryContentSection(),
          const HomeCarePlanActionBarSection(),
        ],
      ),
    );
  }
}
