import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/intake_coordinator_documents_header_section.dart';
import 'sections/intake_coordinator_documents_content_summary_section.dart';
import 'sections/intake_coordinator_documents_primary_content_section.dart';
import 'sections/intake_coordinator_documents_action_bar_section.dart';

class IntakeCoordinatorDocumentsScreen extends StatelessWidget {
  const IntakeCoordinatorDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'intake_coordinator_documents',
      title: 'IntakeCoordinatorDocumentsScreen',
      child: Column(
        children: const [
          const IntakeCoordinatorDocumentsHeaderSection(),
          const IntakeCoordinatorDocumentsContentSummarySection(),
          const IntakeCoordinatorDocumentsPrimaryContentSection(),
          const IntakeCoordinatorDocumentsActionBarSection(),
        ],
      ),
    );
  }
}
