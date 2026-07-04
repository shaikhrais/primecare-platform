import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/communication_header_section.dart';
import 'sections/communication_content_summary_section.dart';
import 'sections/communication_primary_content_section.dart';
import 'sections/communication_action_bar_section.dart';

class CommunicationScreen extends StatelessWidget {
  const CommunicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'communication',
      title: 'CommunicationScreen',
      child: Column(
        children: const [
          const CommunicationHeaderSection(),
          const CommunicationContentSummarySection(),
          const CommunicationPrimaryContentSection(),
          const CommunicationActionBarSection(),
        ],
      ),
    );
  }
}
