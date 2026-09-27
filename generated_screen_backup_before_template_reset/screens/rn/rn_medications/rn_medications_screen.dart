import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rn_medications_header_section.dart';
import 'sections/rn_medications_content_summary_section.dart';
import 'sections/rn_medications_primary_content_section.dart';
import 'sections/rn_medications_action_bar_section.dart';

class RnMedicationsScreen extends StatelessWidget {
  const RnMedicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rn_medications',
      title: 'RnMedicationsScreen',
      child: Column(
        children: const [
          const RnMedicationsHeaderSection(),
          const RnMedicationsContentSummarySection(),
          const RnMedicationsPrimaryContentSection(),
          const RnMedicationsActionBarSection(),
        ],
      ),
    );
  }
}
