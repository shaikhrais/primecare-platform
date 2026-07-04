import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/ceo_alerts_and_risks_header_section.dart';
import 'sections/ceo_alerts_and_risks_content_summary_section.dart';
import 'sections/ceo_alerts_and_risks_primary_content_section.dart';
import 'sections/ceo_alerts_and_risks_action_bar_section.dart';

class CeoAlertsAndRisksScreen extends StatelessWidget {
  const CeoAlertsAndRisksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'ceo_alerts_and_risks',
      title: 'Ceo Alerts And Risks',
      child: Column(
        children: const [
          const CeoAlertsAndRisksHeaderSection(),
          const CeoAlertsAndRisksContentSummarySection(),
          const CeoAlertsAndRisksPrimaryContentSection(),
          const CeoAlertsAndRisksActionBarSection(),
        ],
      ),
    );
  }
}
