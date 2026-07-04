import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/documents_header_section.dart';
import 'sections/documents_content_summary_section.dart';
import 'sections/documents_primary_content_section.dart';
import 'sections/documents_action_bar_section.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'documents',
      title: 'DocumentsScreen',
      child: Column(
        children: const [
          const DocumentsHeaderSection(),
          const DocumentsContentSummarySection(),
          const DocumentsPrimaryContentSection(),
          const DocumentsActionBarSection(),
        ],
      ),
    );
  }
}
