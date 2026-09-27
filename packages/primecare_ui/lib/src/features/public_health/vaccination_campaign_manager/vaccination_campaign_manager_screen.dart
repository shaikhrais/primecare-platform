import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/vaccination_campaign_manager_header_section.dart';
import 'sections/vaccination_campaign_manager_content_summary_section.dart';
import 'sections/vaccination_campaign_manager_primary_content_section.dart';
import 'sections/vaccination_campaign_manager_action_bar_section.dart';

class VaccinationCampaignManagerScreen extends StatelessWidget {
  const VaccinationCampaignManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'vaccination_campaign_manager',
      title: 'Vaccination Campaign Manager',
      child: Column(
        children: const [
          const VaccinationCampaignManagerHeaderSection(),
          const VaccinationCampaignManagerContentSummarySection(),
          const VaccinationCampaignManagerPrimaryContentSection(),
          const VaccinationCampaignManagerActionBarSection(),
        ],
      ),
    );
  }
}
