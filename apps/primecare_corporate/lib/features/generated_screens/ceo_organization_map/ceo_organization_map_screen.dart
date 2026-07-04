import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/ceo_organization_map_header_section.dart';
import 'sections/ceo_organization_map_content_summary_section.dart';
import 'sections/ceo_organization_map_primary_content_section.dart';
import 'sections/ceo_organization_map_action_bar_section.dart';

class CeoOrganizationMapScreen extends StatelessWidget {
  const CeoOrganizationMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'ceo_organization_map',
      title: 'Ceo Organization Map',
      child: Column(
        children: const [
          const CeoOrganizationMapHeaderSection(),
          const CeoOrganizationMapContentSummarySection(),
          const CeoOrganizationMapPrimaryContentSection(),
          const CeoOrganizationMapActionBarSection(),
        ],
      ),
    );
  }
}
