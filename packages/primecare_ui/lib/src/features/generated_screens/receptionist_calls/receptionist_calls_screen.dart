import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/receptionist_calls_header_section.dart';
import 'sections/receptionist_calls_content_summary_section.dart';
import 'sections/receptionist_calls_primary_content_section.dart';
import 'sections/receptionist_calls_action_bar_section.dart';

class ReceptionistCallsScreen extends StatelessWidget {
  const ReceptionistCallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'receptionist_calls',
      title: 'Receptionist Calls',
      child: Column(
        children: const [
          const ReceptionistCallsHeaderSection(),
          const ReceptionistCallsContentSummarySection(),
          const ReceptionistCallsPrimaryContentSection(),
          const ReceptionistCallsActionBarSection(),
        ],
      ),
    );
  }
}
