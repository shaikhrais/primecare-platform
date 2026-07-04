import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/agent_dispatch_header_section.dart';
import 'sections/agent_dispatch_content_summary_section.dart';
import 'sections/agent_dispatch_primary_content_section.dart';
import 'sections/agent_dispatch_action_bar_section.dart';

class AgentDispatchScreen extends StatelessWidget {
  const AgentDispatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'agent_dispatch',
      title: 'AgentDispatchScreen',
      child: Column(
        children: const [
          const AgentDispatchHeaderSection(),
          const AgentDispatchContentSummarySection(),
          const AgentDispatchPrimaryContentSection(),
          const AgentDispatchActionBarSection(),
        ],
      ),
    );
  }
}
