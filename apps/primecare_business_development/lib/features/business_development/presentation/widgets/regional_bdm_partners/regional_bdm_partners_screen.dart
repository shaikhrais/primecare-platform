import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/regional_bdm_partners_header_section.dart';
import 'sections/regional_bdm_partners_content_summary_section.dart';
import 'sections/regional_bdm_partners_primary_content_section.dart';
import 'sections/regional_bdm_partners_action_bar_section.dart';

class RegionalBdmPartnersScreen extends StatelessWidget {
  const RegionalBdmPartnersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'regional_bdm_partners',
      title: 'Regional Bdm Partners',
      child: Column(
        children: const [
          const RegionalBdmPartnersHeaderSection(),
          const RegionalBdmPartnersContentSummarySection(),
          const RegionalBdmPartnersPrimaryContentSection(),
          const RegionalBdmPartnersActionBarSection(),
        ],
      ),
    );
  }
}
