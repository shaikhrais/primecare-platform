import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/expense_management_header_section.dart';
import 'sections/expense_management_content_summary_section.dart';
import 'sections/expense_management_primary_content_section.dart';
import 'sections/expense_management_action_bar_section.dart';

class ExpenseManagementScreen extends StatelessWidget {
  const ExpenseManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'expense_management',
      title: 'ExpenseManagementScreen',
      child: Column(
        children: const [
          const ExpenseManagementHeaderSection(),
          const ExpenseManagementContentSummarySection(),
          const ExpenseManagementPrimaryContentSection(),
          const ExpenseManagementActionBarSection(),
        ],
      ),
    );
  }
}
