import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rn_vitals_header_section.dart';
import 'sections/rn_vitals_content_summary_section.dart';
import 'sections/rn_vitals_primary_content_section.dart';
import 'sections/rn_vitals_action_bar_section.dart';

class RnVitalsScreen extends StatelessWidget {
  const RnVitalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rn_vitals',
      title: 'RnVitalsScreen',
      child: Column(
        children: const [
          const RnVitalsHeaderSection(),
          const RnVitalsContentSummarySection(),
          const RnVitalsPrimaryContentSection(),
          const RnVitalsActionBarSection(),
        ],
      ),
    );
  }
}
