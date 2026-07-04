import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_hiring_offers_header_section.dart';
import 'sections/hr_hiring_offers_content_summary_section.dart';
import 'sections/hr_hiring_offers_primary_content_section.dart';
import 'sections/hr_hiring_offers_action_bar_section.dart';

class HrHiringOffersScreen extends StatelessWidget {
  const HrHiringOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_hiring_offers',
      title: 'HrHiringOffersScreen',
      child: Column(
        children: const [
          const HrHiringOffersHeaderSection(),
          const HrHiringOffersContentSummarySection(),
          const HrHiringOffersPrimaryContentSection(),
          const HrHiringOffersActionBarSection(),
        ],
      ),
    );
  }
}
