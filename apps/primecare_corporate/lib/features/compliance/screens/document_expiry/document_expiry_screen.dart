import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/document_expiry_header_section.dart';
import 'sections/document_expiry_content_summary_section.dart';
import 'sections/document_expiry_primary_content_section.dart';
import 'sections/document_expiry_action_bar_section.dart';

class DocumentExpiryScreen extends StatelessWidget {
  const DocumentExpiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'document_expiry',
      title: 'Document Expiry',
      child: Column(
        children: const [
          const DocumentExpiryHeaderSection(),
          const DocumentExpiryContentSummarySection(),
          const DocumentExpiryPrimaryContentSection(),
          const DocumentExpiryActionBarSection(),
        ],
      ),
    );
  }
}
