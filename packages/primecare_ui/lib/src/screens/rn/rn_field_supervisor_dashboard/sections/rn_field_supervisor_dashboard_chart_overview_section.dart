import 'package:flutter/widgets.dart';

import '../../../../components/prime_dashboard_status_section.dart';

class RnFieldSupervisorDashboardChartOverviewSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const RnFieldSupervisorDashboardChartOverviewSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) => const PrimeDashboardStatusSection(
    semanticLabel: 'rn_field_supervisor_dashboard_chart_overview_title',
    heading: 'Chart Overview Section',
    status: 'Clinical Care Operations Status.',
  );
}
