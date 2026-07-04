import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/customer_support_tickets_header_section.dart';
import 'sections/customer_support_tickets_content_summary_section.dart';
import 'sections/customer_support_tickets_primary_content_section.dart';
import 'sections/customer_support_tickets_action_bar_section.dart';

class CustomerSupportTicketsScreen extends StatelessWidget {
  const CustomerSupportTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'customer_support_tickets',
      title: 'Customer Support Tickets',
      child: Column(
        children: const [
          const CustomerSupportTicketsHeaderSection(),
          const CustomerSupportTicketsContentSummarySection(),
          const CustomerSupportTicketsPrimaryContentSection(),
          const CustomerSupportTicketsActionBarSection(),
        ],
      ),
    );
  }
}
