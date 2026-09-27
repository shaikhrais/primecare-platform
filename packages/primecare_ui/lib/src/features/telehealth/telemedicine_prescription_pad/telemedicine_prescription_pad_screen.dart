import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/telemedicine_prescription_pad_header_section.dart';
import 'sections/telemedicine_prescription_pad_content_summary_section.dart';
import 'sections/telemedicine_prescription_pad_primary_content_section.dart';
import 'sections/telemedicine_prescription_pad_action_bar_section.dart';

class TelemedicinePrescriptionPadScreen extends StatelessWidget {
  const TelemedicinePrescriptionPadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'telemedicine_prescription_pad',
      title: 'Telemedicine Prescription Pad',
      child: Column(
        children: const [
          const TelemedicinePrescriptionPadHeaderSection(),
          const TelemedicinePrescriptionPadContentSummarySection(),
          const TelemedicinePrescriptionPadPrimaryContentSection(),
          const TelemedicinePrescriptionPadActionBarSection(),
        ],
      ),
    );
  }
}
