import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/billing_header_section.dart';
import 'sections/billing_content_summary_section.dart';
import 'sections/billing_primary_content_section.dart';
import 'sections/billing_action_bar_section.dart';

class BillingScreen extends StatelessWidget {
  const BillingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'billing',
      title: 'BillingScreen',
      child: Column(
        children: const [
          const BillingHeaderSection(),
          const BillingContentSummarySection(),
          const BillingPrimaryContentSection(),
          const BillingActionBarSection(),
        ],
      ),
    );
  }
}
