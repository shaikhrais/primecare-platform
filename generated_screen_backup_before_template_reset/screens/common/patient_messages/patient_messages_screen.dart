import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/patient_messages_header_section.dart';
import 'sections/patient_messages_content_summary_section.dart';
import 'sections/patient_messages_primary_content_section.dart';
import 'sections/patient_messages_action_bar_section.dart';

class PatientMessagesScreen extends StatelessWidget {
  const PatientMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'patient_messages',
      title: 'PatientMessagesScreen',
      child: Column(
        children: const [
          const PatientMessagesHeaderSection(),
          const PatientMessagesContentSummarySection(),
          const PatientMessagesPrimaryContentSection(),
          const PatientMessagesActionBarSection(),
        ],
      ),
    );
  }
}
