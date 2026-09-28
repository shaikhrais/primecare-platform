import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/regional_performance_header_section.dart';
import 'sections/regional_performance_form_body_section.dart';
import 'sections/regional_performance_validation_messages_section.dart';
import 'sections/regional_performance_action_bar_section.dart';

class RegionalPerformanceScreen extends StatelessWidget {
  const RegionalPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'regional_performance',
      title: 'Regional Performance',
      child: Column(
        children: const [
          const RegionalPerformanceHeaderSection(),
          const RegionalPerformanceFormBodySection(),
          const RegionalPerformanceValidationMessagesSection(),
          const RegionalPerformanceActionBarSection(),
        ],
      ),
    );
  }
}
