import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/clinical_trial_recruitment_dashboard_header_section.dart';
import 'sections/clinical_trial_recruitment_dashboard_summary_cards_section.dart';
import 'sections/clinical_trial_recruitment_dashboard_chart_overview_section.dart';
import 'sections/clinical_trial_recruitment_dashboard_recent_activity_section.dart';
import 'sections/clinical_trial_recruitment_dashboard_quick_actions_section.dart';

class ClinicalTrialRecruitmentDashboardScreen extends StatelessWidget {
  const ClinicalTrialRecruitmentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'clinical_trial_recruitment_dashboard',
      title: 'Clinical Trial Recruitment Dashboard',
      child: Column(
        children: const [
          const ClinicalTrialRecruitmentDashboardHeaderSection(),
          const ClinicalTrialRecruitmentDashboardSummaryCardsSection(),
          const ClinicalTrialRecruitmentDashboardChartOverviewSection(),
          const ClinicalTrialRecruitmentDashboardRecentActivitySection(),
          const ClinicalTrialRecruitmentDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
