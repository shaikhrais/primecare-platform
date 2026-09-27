import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/coordinator_dispatch_map_header_section.dart';
import 'sections/coordinator_dispatch_map_content_summary_section.dart';
import 'sections/coordinator_dispatch_map_primary_content_section.dart';
import 'sections/coordinator_dispatch_map_action_bar_section.dart';

class CoordinatorDispatchMapScreen extends StatelessWidget {
  const CoordinatorDispatchMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'coordinator_dispatch_map',
      title: 'CoordinatorDispatchMapScreen',
      child: Column(
        children: const [
          const CoordinatorDispatchMapHeaderSection(),
          const CoordinatorDispatchMapContentSummarySection(),
          const CoordinatorDispatchMapPrimaryContentSection(),
          const CoordinatorDispatchMapActionBarSection(),
        ],
      ),
    );
  }
}
