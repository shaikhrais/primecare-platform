import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/ceo_region_performance_header_section.dart';
import 'sections/ceo_region_performance_form_body_section.dart';
import 'sections/ceo_region_performance_validation_messages_section.dart';
import 'sections/ceo_region_performance_action_bar_section.dart';

class CeoRegionPerformanceScreen extends StatelessWidget {
  const CeoRegionPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'ceo_region_performance',
      title: 'Ceo Region Performance',
      child: Column(
        children: const [
          const CeoRegionPerformanceHeaderSection(),
          const CeoRegionPerformanceFormBodySection(),
          const CeoRegionPerformanceValidationMessagesSection(),
          const CeoRegionPerformanceActionBarSection(),
        ],
      ),
    );
  }
}
