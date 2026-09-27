import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/finance_director_cashflow_header_section.dart';
import 'sections/finance_director_cashflow_content_summary_section.dart';
import 'sections/finance_director_cashflow_primary_content_section.dart';
import 'sections/finance_director_cashflow_action_bar_section.dart';

class FinanceDirectorCashflowScreen extends StatelessWidget {
  const FinanceDirectorCashflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'finance_director_cashflow',
      title: 'Finance Director Cashflow',
      child: Column(
        children: const [
          const FinanceDirectorCashflowHeaderSection(),
          const FinanceDirectorCashflowContentSummarySection(),
          const FinanceDirectorCashflowPrimaryContentSection(),
          const FinanceDirectorCashflowActionBarSection(),
        ],
      ),
    );
  }
}
