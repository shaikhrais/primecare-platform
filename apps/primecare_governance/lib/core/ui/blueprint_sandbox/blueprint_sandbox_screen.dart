import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/blueprint_sandbox_header_section.dart';
import 'sections/blueprint_sandbox_content_summary_section.dart';
import 'sections/blueprint_sandbox_primary_content_section.dart';
import 'sections/blueprint_sandbox_action_bar_section.dart';

class BlueprintSandboxScreen extends StatelessWidget {
  const BlueprintSandboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'blueprint_sandbox',
      title: 'Blueprint Sandbox',
      child: Column(
        children: const [
          const BlueprintSandboxHeaderSection(),
          const BlueprintSandboxContentSummarySection(),
          const BlueprintSandboxPrimaryContentSection(),
          const BlueprintSandboxActionBarSection(),
        ],
      ),
    );
  }
}
