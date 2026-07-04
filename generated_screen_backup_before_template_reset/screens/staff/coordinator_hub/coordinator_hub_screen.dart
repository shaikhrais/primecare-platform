import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/coordinator_hub_header_section.dart';
import 'sections/coordinator_hub_content_summary_section.dart';
import 'sections/coordinator_hub_primary_content_section.dart';
import 'sections/coordinator_hub_action_bar_section.dart';

class CoordinatorHubScreen extends StatelessWidget {
  const CoordinatorHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'coordinator_hub',
      title: 'CoordinatorHubScreen',
      child: Column(
        children: const [
          const CoordinatorHubHeaderSection(),
          const CoordinatorHubContentSummarySection(),
          const CoordinatorHubPrimaryContentSection(),
          const CoordinatorHubActionBarSection(),
        ],
      ),
    );
  }
}
