import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/api_monitoring_header_section.dart';
import 'sections/api_monitoring_content_summary_section.dart';
import 'sections/api_monitoring_primary_content_section.dart';
import 'sections/api_monitoring_action_bar_section.dart';

class ApiMonitoringScreen extends StatelessWidget {
  const ApiMonitoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'api_monitoring',
      title: 'ApiMonitoringScreen',
      child: Column(
        children: const [
          const ApiMonitoringHeaderSection(),
          const ApiMonitoringContentSummarySection(),
          const ApiMonitoringPrimaryContentSection(),
          const ApiMonitoringActionBarSection(),
        ],
      ),
    );
  }
}
