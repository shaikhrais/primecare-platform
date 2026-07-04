import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/payroll_header_section.dart';
import 'sections/payroll_content_summary_section.dart';
import 'sections/payroll_primary_content_section.dart';
import 'sections/payroll_action_bar_section.dart';

class PayrollScreen extends StatelessWidget {
  const PayrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'payroll',
      title: 'PayrollScreen',
      child: Column(
        children: const [
          const PayrollHeaderSection(),
          const PayrollContentSummarySection(),
          const PayrollPrimaryContentSection(),
          const PayrollActionBarSection(),
        ],
      ),
    );
  }
}
