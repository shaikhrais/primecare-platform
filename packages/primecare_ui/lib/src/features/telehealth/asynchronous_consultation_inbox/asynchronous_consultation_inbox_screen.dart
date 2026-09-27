import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/asynchronous_consultation_inbox_header_section.dart';
import 'sections/asynchronous_consultation_inbox_content_summary_section.dart';
import 'sections/asynchronous_consultation_inbox_primary_content_section.dart';
import 'sections/asynchronous_consultation_inbox_action_bar_section.dart';

class AsynchronousConsultationInboxScreen extends StatelessWidget {
  const AsynchronousConsultationInboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'asynchronous_consultation_inbox',
      title: 'Asynchronous Consultation Inbox',
      child: Column(
        children: const [
          const AsynchronousConsultationInboxHeaderSection(),
          const AsynchronousConsultationInboxContentSummarySection(),
          const AsynchronousConsultationInboxPrimaryContentSection(),
          const AsynchronousConsultationInboxActionBarSection(),
        ],
      ),
    );
  }
}
