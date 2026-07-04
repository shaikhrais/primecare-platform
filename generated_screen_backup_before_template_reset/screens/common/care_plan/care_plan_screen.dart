import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/care_plan_header_section.dart';
import 'sections/care_plan_content_summary_section.dart';
import 'sections/care_plan_primary_content_section.dart';
import 'sections/care_plan_action_bar_section.dart';

class CarePlanScreen extends StatelessWidget {
  const CarePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'care_plan',
      title: 'CarePlanScreen',
      child: Column(
        children: const [
          const CarePlanHeaderSection(),
          const CarePlanContentSummarySection(),
          const CarePlanPrimaryContentSection(),
          const CarePlanActionBarSection(),
        ],
      ),
    );
  }
}
