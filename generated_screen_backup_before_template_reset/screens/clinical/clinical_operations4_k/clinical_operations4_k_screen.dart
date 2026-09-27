import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/clinical_operations4_k_header_section.dart';
import 'sections/clinical_operations4_k_content_summary_section.dart';
import 'sections/clinical_operations4_k_primary_content_section.dart';
import 'sections/clinical_operations4_k_action_bar_section.dart';

class ClinicalOperations4KScreen extends StatelessWidget {
  const ClinicalOperations4KScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'clinical_operations4_k',
      title: 'ClinicalOperations4KScreen',
      child: Column(
        children: const [
          const ClinicalOperations4KHeaderSection(),
          const ClinicalOperations4KContentSummarySection(),
          const ClinicalOperations4KPrimaryContentSection(),
          const ClinicalOperations4KActionBarSection(),
        ],
      ),
    );
  }
}
