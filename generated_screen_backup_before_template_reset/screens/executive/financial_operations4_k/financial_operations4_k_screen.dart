import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/financial_operations4_k_header_section.dart';
import 'sections/financial_operations4_k_content_summary_section.dart';
import 'sections/financial_operations4_k_primary_content_section.dart';
import 'sections/financial_operations4_k_action_bar_section.dart';

class FinancialOperations4KScreen extends StatelessWidget {
  const FinancialOperations4KScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'financial_operations4_k',
      title: 'FinancialOperations4KScreen',
      child: Column(
        children: const [
          const FinancialOperations4KHeaderSection(),
          const FinancialOperations4KContentSummarySection(),
          const FinancialOperations4KPrimaryContentSection(),
          const FinancialOperations4KActionBarSection(),
        ],
      ),
    );
  }
}
