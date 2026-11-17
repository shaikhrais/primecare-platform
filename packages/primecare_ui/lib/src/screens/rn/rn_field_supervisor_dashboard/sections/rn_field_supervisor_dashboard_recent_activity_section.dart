import 'package:flutter/widgets.dart';

import '../../../../components/prime_dashboard_status_section.dart';

class RnFieldSupervisorDashboardRecentActivitySection extends StatelessWidget {
  final Map<String, dynamic> data;
  const RnFieldSupervisorDashboardRecentActivitySection({super.key, required this.data});

  @override
  Widget build(BuildContext context) => const PrimeDashboardStatusSection(
    semanticLabel: 'rn_field_supervisor_dashboard_recent_activity_title',
    heading: 'Recent Activity Section',
    status: 'Clinical Care Operations Status.',
  );
}
