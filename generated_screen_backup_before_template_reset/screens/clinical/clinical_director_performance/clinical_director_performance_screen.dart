import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/clinical_director_performance_header_section.dart';
import 'sections/clinical_director_performance_form_body_section.dart';
import 'sections/clinical_director_performance_validation_messages_section.dart';
import 'sections/clinical_director_performance_action_bar_section.dart';

class ClinicalDirectorPerformanceScreen extends StatelessWidget {
  const ClinicalDirectorPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'clinical_director_performance',
      title: 'ClinicalDirectorPerformanceScreen',
      child: Column(
        children: const [
          const ClinicalDirectorPerformanceHeaderSection(),
          const ClinicalDirectorPerformanceFormBodySection(),
          const ClinicalDirectorPerformanceValidationMessagesSection(),
          const ClinicalDirectorPerformanceActionBarSection(),
        ],
      ),
    );
  }
}
