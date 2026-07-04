import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/crisis_protocol_trigger_header_section.dart';
import 'sections/crisis_protocol_trigger_content_summary_section.dart';
import 'sections/crisis_protocol_trigger_primary_content_section.dart';
import 'sections/crisis_protocol_trigger_action_bar_section.dart';

class CrisisProtocolTriggerScreen extends StatelessWidget {
  const CrisisProtocolTriggerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'crisis_protocol_trigger',
      title: 'Crisis Protocol Trigger',
      child: Column(
        children: const [
          const CrisisProtocolTriggerHeaderSection(),
          const CrisisProtocolTriggerContentSummarySection(),
          const CrisisProtocolTriggerPrimaryContentSection(),
          const CrisisProtocolTriggerActionBarSection(),
        ],
      ),
    );
  }
}
