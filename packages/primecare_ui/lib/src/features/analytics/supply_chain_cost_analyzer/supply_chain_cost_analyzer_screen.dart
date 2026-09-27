import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/supply_chain_cost_analyzer_header_section.dart';
import 'sections/supply_chain_cost_analyzer_content_summary_section.dart';
import 'sections/supply_chain_cost_analyzer_primary_content_section.dart';
import 'sections/supply_chain_cost_analyzer_action_bar_section.dart';

class SupplyChainCostAnalyzerScreen extends StatelessWidget {
  const SupplyChainCostAnalyzerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'supply_chain_cost_analyzer',
      title: 'Supply Chain Cost Analyzer',
      child: Column(
        children: const [
          const SupplyChainCostAnalyzerHeaderSection(),
          const SupplyChainCostAnalyzerContentSummarySection(),
          const SupplyChainCostAnalyzerPrimaryContentSection(),
          const SupplyChainCostAnalyzerActionBarSection(),
        ],
      ),
    );
  }
}
