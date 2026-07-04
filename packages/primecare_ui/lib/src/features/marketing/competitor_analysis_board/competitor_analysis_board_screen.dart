import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/competitor_analysis_board_header_section.dart';
import 'sections/competitor_analysis_board_content_summary_section.dart';
import 'sections/competitor_analysis_board_primary_content_section.dart';
import 'sections/competitor_analysis_board_action_bar_section.dart';

class CompetitorAnalysisBoardScreen extends StatelessWidget {
  const CompetitorAnalysisBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'competitor_analysis_board',
      title: 'Competitor Analysis Board',
      child: Column(
        children: const [
          const CompetitorAnalysisBoardHeaderSection(),
          const CompetitorAnalysisBoardContentSummarySection(),
          const CompetitorAnalysisBoardPrimaryContentSection(),
          const CompetitorAnalysisBoardActionBarSection(),
        ],
      ),
    );
  }
}
