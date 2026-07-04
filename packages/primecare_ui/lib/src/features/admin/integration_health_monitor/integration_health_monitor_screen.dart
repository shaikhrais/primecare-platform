import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/integration_health_monitor_header_section.dart';
import 'sections/integration_health_monitor_content_summary_section.dart';
import 'sections/integration_health_monitor_primary_content_section.dart';
import 'sections/integration_health_monitor_action_bar_section.dart';

class IntegrationHealthMonitorScreen extends StatelessWidget {
  const IntegrationHealthMonitorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'integration_health_monitor',
      title: 'Integration Health Monitor',
      child: Column(
        children: const [
          const IntegrationHealthMonitorHeaderSection(),
          const IntegrationHealthMonitorContentSummarySection(),
          const IntegrationHealthMonitorPrimaryContentSection(),
          const IntegrationHealthMonitorActionBarSection(),
        ],
      ),
    );
  }
}
