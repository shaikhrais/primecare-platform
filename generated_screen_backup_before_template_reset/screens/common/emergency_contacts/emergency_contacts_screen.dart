import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/emergency_contacts_header_section.dart';
import 'sections/emergency_contacts_content_summary_section.dart';
import 'sections/emergency_contacts_primary_content_section.dart';
import 'sections/emergency_contacts_action_bar_section.dart';

class EmergencyContactsScreen extends StatelessWidget {
  const EmergencyContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'emergency_contacts',
      title: 'EmergencyContactsScreen',
      child: Column(
        children: const [
          const EmergencyContactsHeaderSection(),
          const EmergencyContactsContentSummarySection(),
          const EmergencyContactsPrimaryContentSection(),
          const EmergencyContactsActionBarSection(),
        ],
      ),
    );
  }
}
