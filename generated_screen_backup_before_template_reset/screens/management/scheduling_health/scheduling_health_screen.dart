import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/scheduling_health_header_section.dart';
import 'sections/scheduling_health_content_summary_section.dart';
import 'sections/scheduling_health_primary_content_section.dart';
import 'sections/scheduling_health_action_bar_section.dart';

class SchedulingHealthScreen extends StatelessWidget {
  const SchedulingHealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'scheduling_health',
      title: 'SchedulingHealthScreen',
      child: Column(
        children: const [
          const SchedulingHealthHeaderSection(),
          const SchedulingHealthContentSummarySection(),
          const SchedulingHealthPrimaryContentSection(),
          const SchedulingHealthActionBarSection(),
        ],
      ),
    );
  }
}
