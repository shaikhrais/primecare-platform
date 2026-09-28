import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_director_certificates_header_section.dart';
import 'sections/training_director_certificates_content_summary_section.dart';
import 'sections/training_director_certificates_primary_content_section.dart';
import 'sections/training_director_certificates_action_bar_section.dart';

class TrainingDirectorCertificatesScreen extends StatelessWidget {
  const TrainingDirectorCertificatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_director_certificates',
      title: 'Training Director Certificates',
      child: Column(
        children: const [
          const TrainingDirectorCertificatesHeaderSection(),
          const TrainingDirectorCertificatesContentSummarySection(),
          const TrainingDirectorCertificatesPrimaryContentSection(),
          const TrainingDirectorCertificatesActionBarSection(),
        ],
      ),
    );
  }
}
