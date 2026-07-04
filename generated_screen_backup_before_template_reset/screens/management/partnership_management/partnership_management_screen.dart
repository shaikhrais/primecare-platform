import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/partnership_management_header_section.dart';
import 'sections/partnership_management_content_summary_section.dart';
import 'sections/partnership_management_primary_content_section.dart';
import 'sections/partnership_management_action_bar_section.dart';

class PartnershipManagementScreen extends StatelessWidget {
  const PartnershipManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'partnership_management',
      title: 'PartnershipManagementScreen',
      child: Column(
        children: const [
          const PartnershipManagementHeaderSection(),
          const PartnershipManagementContentSummarySection(),
          const PartnershipManagementPrimaryContentSection(),
          const PartnershipManagementActionBarSection(),
        ],
      ),
    );
  }
}
