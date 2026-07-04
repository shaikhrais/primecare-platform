import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/digital_symptom_checker_header_section.dart';
import 'sections/digital_symptom_checker_content_summary_section.dart';
import 'sections/digital_symptom_checker_primary_content_section.dart';
import 'sections/digital_symptom_checker_action_bar_section.dart';

class DigitalSymptomCheckerScreen extends StatelessWidget {
  const DigitalSymptomCheckerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'digital_symptom_checker',
      title: 'Digital Symptom Checker',
      child: Column(
        children: const [
          const DigitalSymptomCheckerHeaderSection(),
          const DigitalSymptomCheckerContentSummarySection(),
          const DigitalSymptomCheckerPrimaryContentSection(),
          const DigitalSymptomCheckerActionBarSection(),
        ],
      ),
    );
  }
}
