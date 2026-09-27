import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rn_charting_header_section.dart';
import 'sections/rn_charting_content_summary_section.dart';
import 'sections/rn_charting_primary_content_section.dart';
import 'sections/rn_charting_action_bar_section.dart';

class RnChartingScreen extends StatelessWidget {
  const RnChartingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rn_charting',
      title: 'Rn Charting',
      child: Column(
        children: const [
          const RnChartingHeaderSection(),
          const RnChartingContentSummarySection(),
          const RnChartingPrimaryContentSection(),
          const RnChartingActionBarSection(),
        ],
      ),
    );
  }
}
