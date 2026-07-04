import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/certifications_header_section.dart';
import 'sections/certifications_content_summary_section.dart';
import 'sections/certifications_primary_content_section.dart';
import 'sections/certifications_action_bar_section.dart';

class CertificationsScreen extends StatelessWidget {
  const CertificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'certifications',
      title: 'Certifications',
      child: Column(
        children: const [
          const CertificationsHeaderSection(),
          const CertificationsContentSummarySection(),
          const CertificationsPrimaryContentSection(),
          const CertificationsActionBarSection(),
        ],
      ),
    );
  }
}
