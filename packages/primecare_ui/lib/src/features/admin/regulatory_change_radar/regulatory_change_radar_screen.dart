import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/regulatory_change_radar_header_section.dart';
import 'sections/regulatory_change_radar_content_summary_section.dart';
import 'sections/regulatory_change_radar_primary_content_section.dart';
import 'sections/regulatory_change_radar_action_bar_section.dart';

class RegulatoryChangeRadarScreen extends StatelessWidget {
  const RegulatoryChangeRadarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'regulatory_change_radar',
      title: 'Regulatory Change Radar',
      child: Column(
        children: const [
          const RegulatoryChangeRadarHeaderSection(),
          const RegulatoryChangeRadarContentSummarySection(),
          const RegulatoryChangeRadarPrimaryContentSection(),
          const RegulatoryChangeRadarActionBarSection(),
        ],
      ),
    );
  }
}
