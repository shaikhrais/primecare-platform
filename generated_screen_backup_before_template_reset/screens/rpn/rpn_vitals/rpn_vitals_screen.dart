import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rpn_vitals_header_section.dart';
import 'sections/rpn_vitals_content_summary_section.dart';
import 'sections/rpn_vitals_primary_content_section.dart';
import 'sections/rpn_vitals_action_bar_section.dart';

class RpnVitalsScreen extends StatelessWidget {
  const RpnVitalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rpn_vitals',
      title: 'RpnVitalsScreen',
      child: Column(
        children: const [
          const RpnVitalsHeaderSection(),
          const RpnVitalsContentSummarySection(),
          const RpnVitalsPrimaryContentSection(),
          const RpnVitalsActionBarSection(),
        ],
      ),
    );
  }
}
