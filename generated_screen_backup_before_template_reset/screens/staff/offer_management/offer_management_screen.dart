import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/offer_management_header_section.dart';
import 'sections/offer_management_content_summary_section.dart';
import 'sections/offer_management_primary_content_section.dart';
import 'sections/offer_management_action_bar_section.dart';

class OfferManagementScreen extends StatelessWidget {
  const OfferManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'offer_management',
      title: 'OfferManagementScreen',
      child: Column(
        children: const [
          const OfferManagementHeaderSection(),
          const OfferManagementContentSummarySection(),
          const OfferManagementPrimaryContentSection(),
          const OfferManagementActionBarSection(),
        ],
      ),
    );
  }
}
