import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cfo_payroll_header_section.dart';
import 'sections/cfo_payroll_content_summary_section.dart';
import 'sections/cfo_payroll_primary_content_section.dart';
import 'sections/cfo_payroll_action_bar_section.dart';

class CfoPayrollScreen extends StatelessWidget {
  const CfoPayrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cfo_payroll',
      title: 'CfoPayrollScreen',
      child: Column(
        children: const [
          const CfoPayrollHeaderSection(),
          const CfoPayrollContentSummarySection(),
          const CfoPayrollPrimaryContentSection(),
          const CfoPayrollActionBarSection(),
        ],
      ),
    );
  }
}
