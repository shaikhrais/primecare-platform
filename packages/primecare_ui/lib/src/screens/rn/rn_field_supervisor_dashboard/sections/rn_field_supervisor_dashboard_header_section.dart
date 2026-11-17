import 'package:flutter/widgets.dart';

import '../../../../components/prime_dashboard_status_section.dart';

class RnFieldSupervisorDashboardHeaderSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const RnFieldSupervisorDashboardHeaderSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) => const PrimeDashboardStatusSection(
    semanticLabel: 'rn_field_supervisor_dashboard_header_title',
    heading: 'Header Section',
    status: 'Clinical Care Operations Status.',
  );
}
