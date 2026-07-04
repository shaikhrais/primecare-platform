import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/intake_coordinator_referrals_header_section.dart';
import 'sections/intake_coordinator_referrals_content_summary_section.dart';
import 'sections/intake_coordinator_referrals_primary_content_section.dart';
import 'sections/intake_coordinator_referrals_action_bar_section.dart';

class IntakeCoordinatorReferralsScreen extends StatelessWidget {
  const IntakeCoordinatorReferralsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'intake_coordinator_referrals',
      title: 'IntakeCoordinatorReferralsScreen',
      child: Column(
        children: const [
          const IntakeCoordinatorReferralsHeaderSection(),
          const IntakeCoordinatorReferralsContentSummarySection(),
          const IntakeCoordinatorReferralsPrimaryContentSection(),
          const IntakeCoordinatorReferralsActionBarSection(),
        ],
      ),
    );
  }
}
