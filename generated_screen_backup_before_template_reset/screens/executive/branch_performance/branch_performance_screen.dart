import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/branch_performance_header_section.dart';
import 'sections/branch_performance_form_body_section.dart';
import 'sections/branch_performance_validation_messages_section.dart';
import 'sections/branch_performance_action_bar_section.dart';

class BranchPerformanceScreen extends StatelessWidget {
  const BranchPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'branch_performance',
      title: 'BranchPerformanceScreen',
      child: Column(
        children: const [
          const BranchPerformanceHeaderSection(),
          const BranchPerformanceFormBodySection(),
          const BranchPerformanceValidationMessagesSection(),
          const BranchPerformanceActionBarSection(),
        ],
      ),
    );
  }
}
