import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/regional_bdm_deal_tracker_header_section.dart';
import 'sections/regional_bdm_deal_tracker_content_summary_section.dart';
import 'sections/regional_bdm_deal_tracker_primary_content_section.dart';
import 'sections/regional_bdm_deal_tracker_action_bar_section.dart';

class RegionalBdmDealTrackerScreen extends StatelessWidget {
  const RegionalBdmDealTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'regional_bdm_deal_tracker',
      title: 'Regional Bdm Deal Tracker',
      child: Column(
        children: const [
          const RegionalBdmDealTrackerHeaderSection(),
          const RegionalBdmDealTrackerContentSummarySection(),
          const RegionalBdmDealTrackerPrimaryContentSection(),
          const RegionalBdmDealTrackerActionBarSection(),
        ],
      ),
    );
  }
}
