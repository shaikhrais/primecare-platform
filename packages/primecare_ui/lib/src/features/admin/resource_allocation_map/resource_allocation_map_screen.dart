import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/resource_allocation_map_header_section.dart';
import 'sections/resource_allocation_map_content_summary_section.dart';
import 'sections/resource_allocation_map_primary_content_section.dart';
import 'sections/resource_allocation_map_action_bar_section.dart';

class ResourceAllocationMapScreen extends StatelessWidget {
  const ResourceAllocationMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'resource_allocation_map',
      title: 'Resource Allocation Map',
      child: Column(
        children: const [
          const ResourceAllocationMapHeaderSection(),
          const ResourceAllocationMapContentSummarySection(),
          const ResourceAllocationMapPrimaryContentSection(),
          const ResourceAllocationMapActionBarSection(),
        ],
      ),
    );
  }
}
