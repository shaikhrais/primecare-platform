import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/certificates_header_section.dart';
import 'sections/certificates_content_summary_section.dart';
import 'sections/certificates_primary_content_section.dart';
import 'sections/certificates_action_bar_section.dart';

class CertificatesScreen extends StatelessWidget {
  const CertificatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'certificates',
      title: 'Certificates',
      child: Column(
        children: const [
          const CertificatesHeaderSection(),
          const CertificatesContentSummarySection(),
          const CertificatesPrimaryContentSection(),
          const CertificatesActionBarSection(),
        ],
      ),
    );
  }
}
