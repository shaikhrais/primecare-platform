import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rpn_medications_header_section.dart';
import 'sections/rpn_medications_content_summary_section.dart';
import 'sections/rpn_medications_primary_content_section.dart';
import 'sections/rpn_medications_action_bar_section.dart';

class RpnMedicationsScreen extends StatelessWidget {
  const RpnMedicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rpn_medications',
      title: 'RpnMedicationsScreen',
      child: Column(
        children: const [
          const RpnMedicationsHeaderSection(),
          const RpnMedicationsContentSummarySection(),
          const RpnMedicationsPrimaryContentSection(),
          const RpnMedicationsActionBarSection(),
        ],
      ),
    );
  }
}
