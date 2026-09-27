import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/service_procurement_header_section.dart';
import 'sections/service_procurement_content_summary_section.dart';
import 'sections/service_procurement_primary_content_section.dart';
import 'sections/service_procurement_action_bar_section.dart';

class ServiceProcurementScreen extends StatelessWidget {
  const ServiceProcurementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'service_procurement',
      title: 'Service Procurement',
      child: Column(
        children: const [
          const ServiceProcurementHeaderSection(),
          const ServiceProcurementContentSummarySection(),
          const ServiceProcurementPrimaryContentSection(),
          const ServiceProcurementActionBarSection(),
        ],
      ),
    );
  }
}
