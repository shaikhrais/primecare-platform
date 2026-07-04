import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/partnership_manager_active_deals_header_section.dart';
import 'sections/partnership_manager_active_deals_content_summary_section.dart';
import 'sections/partnership_manager_active_deals_primary_content_section.dart';
import 'sections/partnership_manager_active_deals_action_bar_section.dart';

class PartnershipManagerActiveDealsScreen extends StatelessWidget {
  const PartnershipManagerActiveDealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'partnership_manager_active_deals',
      title: 'Partnership Manager Active Deals',
      child: Column(
        children: const [
          const PartnershipManagerActiveDealsHeaderSection(),
          const PartnershipManagerActiveDealsContentSummarySection(),
          const PartnershipManagerActiveDealsPrimaryContentSection(),
          const PartnershipManagerActiveDealsActionBarSection(),
        ],
      ),
    );
  }
}
