import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_documents_header_section.dart';
import 'sections/psw_documents_content_summary_section.dart';
import 'sections/psw_documents_primary_content_section.dart';
import 'sections/psw_documents_action_bar_section.dart';

class PswDocumentsScreen extends StatelessWidget {
  const PswDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_documents',
      title: 'Documents',
      child: Column(
        children: const [
          const PswDocumentsHeaderSection(),
          const PswDocumentsContentSummarySection(),
          const PswDocumentsPrimaryContentSection(),
          const PswDocumentsActionBarSection(),
        ],
      ),
    );
  }
}
