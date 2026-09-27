import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/medical_library_access_portal_header_section.dart';
import 'sections/medical_library_access_portal_content_summary_section.dart';
import 'sections/medical_library_access_portal_primary_content_section.dart';
import 'sections/medical_library_access_portal_action_bar_section.dart';

class MedicalLibraryAccessPortalScreen extends StatelessWidget {
  const MedicalLibraryAccessPortalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'medical_library_access_portal',
      title: 'Medical Library Access Portal',
      child: Column(
        children: const [
          const MedicalLibraryAccessPortalHeaderSection(),
          const MedicalLibraryAccessPortalContentSummarySection(),
          const MedicalLibraryAccessPortalPrimaryContentSection(),
          const MedicalLibraryAccessPortalActionBarSection(),
        ],
      ),
    );
  }
}
