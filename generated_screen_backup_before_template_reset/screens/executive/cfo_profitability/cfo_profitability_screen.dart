import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cfo_profitability_header_section.dart';
import 'sections/cfo_profitability_content_summary_section.dart';
import 'sections/cfo_profitability_primary_content_section.dart';
import 'sections/cfo_profitability_action_bar_section.dart';

class CfoProfitabilityScreen extends StatelessWidget {
  const CfoProfitabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cfo_profitability',
      title: 'CfoProfitabilityScreen',
      child: Column(
        children: const [
          const CfoProfitabilityHeaderSection(),
          const CfoProfitabilityContentSummarySection(),
          const CfoProfitabilityPrimaryContentSection(),
          const CfoProfitabilityActionBarSection(),
        ],
      ),
    );
  }
}
