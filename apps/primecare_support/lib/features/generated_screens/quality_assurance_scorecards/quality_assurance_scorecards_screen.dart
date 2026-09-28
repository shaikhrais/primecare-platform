import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/quality_assurance_scorecards_header_section.dart';
import 'sections/quality_assurance_scorecards_content_summary_section.dart';
import 'sections/quality_assurance_scorecards_primary_content_section.dart';
import 'sections/quality_assurance_scorecards_action_bar_section.dart';

class QualityAssuranceScorecardsScreen extends StatelessWidget {
  const QualityAssuranceScorecardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'quality_assurance_scorecards',
      title: 'Quality Assurance Scorecards',
      child: Column(
        children: const [
          const QualityAssuranceScorecardsHeaderSection(),
          const QualityAssuranceScorecardsContentSummarySection(),
          const QualityAssuranceScorecardsPrimaryContentSection(),
          const QualityAssuranceScorecardsActionBarSection(),
        ],
      ),
    );
  }
}
