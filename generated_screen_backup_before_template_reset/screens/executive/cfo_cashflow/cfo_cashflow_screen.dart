import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cfo_cashflow_header_section.dart';
import 'sections/cfo_cashflow_content_summary_section.dart';
import 'sections/cfo_cashflow_primary_content_section.dart';
import 'sections/cfo_cashflow_action_bar_section.dart';

class CfoCashflowScreen extends StatelessWidget {
  const CfoCashflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cfo_cashflow',
      title: 'CfoCashflowScreen',
      child: Column(
        children: const [
          const CfoCashflowHeaderSection(),
          const CfoCashflowContentSummarySection(),
          const CfoCashflowPrimaryContentSection(),
          const CfoCashflowActionBarSection(),
        ],
      ),
    );
  }
}
