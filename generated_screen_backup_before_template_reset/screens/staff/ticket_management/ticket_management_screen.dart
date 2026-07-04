import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/ticket_management_header_section.dart';
import 'sections/ticket_management_content_summary_section.dart';
import 'sections/ticket_management_primary_content_section.dart';
import 'sections/ticket_management_action_bar_section.dart';

class TicketManagementScreen extends StatelessWidget {
  const TicketManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'ticket_management',
      title: 'TicketManagementScreen',
      child: Column(
        children: const [
          const TicketManagementHeaderSection(),
          const TicketManagementContentSummarySection(),
          const TicketManagementPrimaryContentSection(),
          const TicketManagementActionBarSection(),
        ],
      ),
    );
  }
}
