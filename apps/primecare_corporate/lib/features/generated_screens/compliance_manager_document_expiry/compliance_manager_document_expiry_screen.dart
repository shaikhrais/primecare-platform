import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/compliance_manager_document_expiry_header_section.dart';
import 'sections/compliance_manager_document_expiry_content_summary_section.dart';
import 'sections/compliance_manager_document_expiry_primary_content_section.dart';
import 'sections/compliance_manager_document_expiry_action_bar_section.dart';

class ComplianceManagerDocumentExpiryScreen extends StatelessWidget {
  const ComplianceManagerDocumentExpiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'compliance_manager_document_expiry',
      title: 'Compliance Manager Document Expiry',
      child: Column(
        children: const [
          const ComplianceManagerDocumentExpiryHeaderSection(),
          const ComplianceManagerDocumentExpiryContentSummarySection(),
          const ComplianceManagerDocumentExpiryPrimaryContentSection(),
          const ComplianceManagerDocumentExpiryActionBarSection(),
        ],
      ),
    );
  }
}
