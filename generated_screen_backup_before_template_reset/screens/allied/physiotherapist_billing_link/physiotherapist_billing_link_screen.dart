import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/physiotherapist_billing_link_header_section.dart';
import 'sections/physiotherapist_billing_link_content_summary_section.dart';
import 'sections/physiotherapist_billing_link_primary_content_section.dart';
import 'sections/physiotherapist_billing_link_action_bar_section.dart';

class PhysiotherapistBillingLinkScreen extends StatelessWidget {
  const PhysiotherapistBillingLinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'physiotherapist_billing_link',
      title: 'PhysiotherapistBillingLinkScreen',
      child: Column(
        children: const [
          const PhysiotherapistBillingLinkHeaderSection(),
          const PhysiotherapistBillingLinkContentSummarySection(),
          const PhysiotherapistBillingLinkPrimaryContentSection(),
          const PhysiotherapistBillingLinkActionBarSection(),
        ],
      ),
    );
  }
}
