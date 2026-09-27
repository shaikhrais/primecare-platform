import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cfo_expenses_header_section.dart';
import 'sections/cfo_expenses_content_summary_section.dart';
import 'sections/cfo_expenses_primary_content_section.dart';
import 'sections/cfo_expenses_action_bar_section.dart';

class CfoExpensesScreen extends StatelessWidget {
  const CfoExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cfo_expenses',
      title: 'CfoExpensesScreen',
      child: Column(
        children: const [
          const CfoExpensesHeaderSection(),
          const CfoExpensesContentSummarySection(),
          const CfoExpensesPrimaryContentSection(),
          const CfoExpensesActionBarSection(),
        ],
      ),
    );
  }
}
