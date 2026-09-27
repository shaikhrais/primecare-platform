import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/touchpoint_analyzer_header_section.dart';
import 'sections/touchpoint_analyzer_content_summary_section.dart';
import 'sections/touchpoint_analyzer_primary_content_section.dart';
import 'sections/touchpoint_analyzer_action_bar_section.dart';

class TouchpointAnalyzerScreen extends StatelessWidget {
  const TouchpointAnalyzerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'touchpoint_analyzer',
      title: 'Touchpoint Analyzer',
      child: Column(
        children: const [
          const TouchpointAnalyzerHeaderSection(),
          const TouchpointAnalyzerContentSummarySection(),
          const TouchpointAnalyzerPrimaryContentSection(),
          const TouchpointAnalyzerActionBarSection(),
        ],
      ),
    );
  }
}
