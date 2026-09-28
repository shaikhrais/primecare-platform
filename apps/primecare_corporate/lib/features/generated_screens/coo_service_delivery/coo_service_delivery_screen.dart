import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/coo_service_delivery_header_section.dart';
import 'sections/coo_service_delivery_content_summary_section.dart';
import 'sections/coo_service_delivery_primary_content_section.dart';
import 'sections/coo_service_delivery_action_bar_section.dart';

class CooServiceDeliveryScreen extends StatelessWidget {
  const CooServiceDeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'coo_service_delivery',
      title: 'Coo Service Delivery',
      child: Column(
        children: const [
          const CooServiceDeliveryHeaderSection(),
          const CooServiceDeliveryContentSummarySection(),
          const CooServiceDeliveryPrimaryContentSection(),
          const CooServiceDeliveryActionBarSection(),
        ],
      ),
    );
  }
}
