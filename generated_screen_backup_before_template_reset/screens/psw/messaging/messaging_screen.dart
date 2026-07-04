import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/messaging_header_section.dart';
import 'sections/messaging_content_summary_section.dart';
import 'sections/messaging_primary_content_section.dart';
import 'sections/messaging_action_bar_section.dart';

class MessagingScreen extends StatelessWidget {
  const MessagingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'messaging',
      title: 'MessagingScreen',
      child: Column(
        children: const [
          const MessagingHeaderSection(),
          const MessagingContentSummarySection(),
          const MessagingPrimaryContentSection(),
          const MessagingActionBarSection(),
        ],
      ),
    );
  }
}
