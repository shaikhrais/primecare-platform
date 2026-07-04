import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rmt_billing_link_header_section.dart';
import 'sections/rmt_billing_link_content_summary_section.dart';
import 'sections/rmt_billing_link_primary_content_section.dart';
import 'sections/rmt_billing_link_action_bar_section.dart';

class RmtBillingLinkScreen extends StatelessWidget {
  const RmtBillingLinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rmt_billing_link',
      title: 'RmtBillingLinkScreen',
      child: Column(
        children: const [
          const RmtBillingLinkHeaderSection(),
          const RmtBillingLinkContentSummarySection(),
          const RmtBillingLinkPrimaryContentSection(),
          const RmtBillingLinkActionBarSection(),
        ],
      ),
    );
  }
}
