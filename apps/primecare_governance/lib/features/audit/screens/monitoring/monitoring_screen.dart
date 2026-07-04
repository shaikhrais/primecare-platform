import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/monitoring_header_section.dart';
import 'sections/monitoring_content_summary_section.dart';
import 'sections/monitoring_primary_content_section.dart';
import 'sections/monitoring_action_bar_section.dart';

class MonitoringScreen extends StatelessWidget {
  const MonitoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'monitoring',
      title: 'Monitoring',
      child: Column(
        children: const [
          const MonitoringHeaderSection(),
          const MonitoringContentSummarySection(),
          const MonitoringPrimaryContentSection(),
          const MonitoringActionBarSection(),
        ],
      ),
    );
  }
}
