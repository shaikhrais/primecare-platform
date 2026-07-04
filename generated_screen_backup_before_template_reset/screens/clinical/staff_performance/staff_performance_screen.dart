import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/staff_performance_header_section.dart';
import 'sections/staff_performance_form_body_section.dart';
import 'sections/staff_performance_validation_messages_section.dart';
import 'sections/staff_performance_action_bar_section.dart';

class StaffPerformanceScreen extends StatelessWidget {
  const StaffPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'staff_performance',
      title: 'StaffPerformanceScreen',
      child: Column(
        children: const [
          const StaffPerformanceHeaderSection(),
          const StaffPerformanceFormBodySection(),
          const StaffPerformanceValidationMessagesSection(),
          const StaffPerformanceActionBarSection(),
        ],
      ),
    );
  }
}
