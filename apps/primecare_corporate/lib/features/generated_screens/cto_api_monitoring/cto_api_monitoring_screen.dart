import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cto_api_monitoring_header_section.dart';
import 'sections/cto_api_monitoring_content_summary_section.dart';
import 'sections/cto_api_monitoring_primary_content_section.dart';
import 'sections/cto_api_monitoring_action_bar_section.dart';

class CtoApiMonitoringScreen extends StatelessWidget {
  const CtoApiMonitoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cto_api_monitoring',
      title: 'Cto Api Monitoring',
      child: Column(
        children: const [
          const CtoApiMonitoringHeaderSection(),
          const CtoApiMonitoringContentSummarySection(),
          const CtoApiMonitoringPrimaryContentSection(),
          const CtoApiMonitoringActionBarSection(),
        ],
      ),
    );
  }
}
