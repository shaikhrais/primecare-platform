import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/patient_documents_header_section.dart';
import 'sections/patient_documents_content_summary_section.dart';
import 'sections/patient_documents_primary_content_section.dart';
import 'sections/patient_documents_action_bar_section.dart';

class PatientDocumentsScreen extends StatelessWidget {
  const PatientDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'patient_documents',
      title: 'PatientDocumentsScreen',
      child: Column(
        children: const [
          const PatientDocumentsHeaderSection(),
          const PatientDocumentsContentSummarySection(),
          const PatientDocumentsPrimaryContentSection(),
          const PatientDocumentsActionBarSection(),
        ],
      ),
    );
  }
}
