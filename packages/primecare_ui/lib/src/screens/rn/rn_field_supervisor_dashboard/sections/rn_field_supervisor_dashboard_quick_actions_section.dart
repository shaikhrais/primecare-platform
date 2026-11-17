import 'package:flutter/widgets.dart';

import '../../../../components/prime_dashboard_status_section.dart';

class RnFieldSupervisorDashboardQuickActionsSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const RnFieldSupervisorDashboardQuickActionsSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) => const PrimeDashboardStatusSection(
    semanticLabel: 'rn_field_supervisor_dashboard_quick_actions_title',
    heading: 'Quick Actions Section',
    status: 'Clinical Care Operations Status.',
  );
}
