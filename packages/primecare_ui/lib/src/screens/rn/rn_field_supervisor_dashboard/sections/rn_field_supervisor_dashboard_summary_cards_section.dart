import 'package:flutter/widgets.dart';

import '../../../../components/prime_dashboard_status_section.dart';

class RnFieldSupervisorDashboardSummaryCardsSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const RnFieldSupervisorDashboardSummaryCardsSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) => const PrimeDashboardStatusSection(
    semanticLabel: 'rn_field_supervisor_dashboard_summary_cards_title',
    heading: 'Summary Cards Section',
    status: 'Clinical Care Operations Status.',
  );
}
