import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/environmental_health_hazards_header_section.dart';
import 'sections/environmental_health_hazards_content_summary_section.dart';
import 'sections/environmental_health_hazards_primary_content_section.dart';
import 'sections/environmental_health_hazards_action_bar_section.dart';

class EnvironmentalHealthHazardsScreen extends StatelessWidget {
  const EnvironmentalHealthHazardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'environmental_health_hazards',
      title: 'Environmental Health Hazards',
      child: Column(
        children: const [
          const EnvironmentalHealthHazardsHeaderSection(),
          const EnvironmentalHealthHazardsContentSummarySection(),
          const EnvironmentalHealthHazardsPrimaryContentSection(),
          const EnvironmentalHealthHazardsActionBarSection(),
        ],
      ),
    );
  }
}
