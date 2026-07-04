import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/ticket_center_header_section.dart';
import 'sections/ticket_center_content_summary_section.dart';
import 'sections/ticket_center_primary_content_section.dart';
import 'sections/ticket_center_action_bar_section.dart';

class TicketCenterScreen extends StatelessWidget {
  const TicketCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'ticket_center',
      title: 'Ticket Center',
      child: Column(
        children: const [
          const TicketCenterHeaderSection(),
          const TicketCenterContentSummarySection(),
          const TicketCenterPrimaryContentSection(),
          const TicketCenterActionBarSection(),
        ],
      ),
    );
  }
}
