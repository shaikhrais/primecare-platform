import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/chiropractor_billing_link_header_section.dart';
import 'sections/chiropractor_billing_link_content_summary_section.dart';
import 'sections/chiropractor_billing_link_primary_content_section.dart';
import 'sections/chiropractor_billing_link_action_bar_section.dart';

class ChiropractorBillingLinkScreen extends StatelessWidget {
  const ChiropractorBillingLinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'chiropractor_billing_link',
      title: 'ChiropractorBillingLinkScreen',
      child: Column(
        children: const [
          const ChiropractorBillingLinkHeaderSection(),
          const ChiropractorBillingLinkContentSummarySection(),
          const ChiropractorBillingLinkPrimaryContentSection(),
          const ChiropractorBillingLinkActionBarSection(),
        ],
      ),
    );
  }
}
