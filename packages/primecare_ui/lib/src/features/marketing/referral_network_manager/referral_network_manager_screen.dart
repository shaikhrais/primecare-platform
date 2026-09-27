import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/referral_network_manager_header_section.dart';
import 'sections/referral_network_manager_content_summary_section.dart';
import 'sections/referral_network_manager_primary_content_section.dart';
import 'sections/referral_network_manager_action_bar_section.dart';

class ReferralNetworkManagerScreen extends StatelessWidget {
  const ReferralNetworkManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'referral_network_manager',
      title: 'Referral Network Manager',
      child: Column(
        children: const [
          const ReferralNetworkManagerHeaderSection(),
          const ReferralNetworkManagerContentSummarySection(),
          const ReferralNetworkManagerPrimaryContentSection(),
          const ReferralNetworkManagerActionBarSection(),
        ],
      ),
    );
  }
}
