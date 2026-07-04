import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/remote_patient_monitoring_dashboard_header_section.dart';
import 'sections/remote_patient_monitoring_dashboard_summary_cards_section.dart';
import 'sections/remote_patient_monitoring_dashboard_chart_overview_section.dart';
import 'sections/remote_patient_monitoring_dashboard_recent_activity_section.dart';
import 'sections/remote_patient_monitoring_dashboard_quick_actions_section.dart';

class RemotePatientMonitoringDashboardScreen extends StatelessWidget {
  const RemotePatientMonitoringDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'remote_patient_monitoring_dashboard',
      title: 'Remote Patient Monitoring Dashboard',
      child: Column(
        children: const [
          const RemotePatientMonitoringDashboardHeaderSection(),
          const RemotePatientMonitoringDashboardSummaryCardsSection(),
          const RemotePatientMonitoringDashboardChartOverviewSection(),
          const RemotePatientMonitoringDashboardRecentActivitySection(),
          const RemotePatientMonitoringDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
