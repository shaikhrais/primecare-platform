import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/ecosystem_state_board_header_section.dart';
import 'sections/ecosystem_state_board_content_summary_section.dart';
import 'sections/ecosystem_state_board_primary_content_section.dart';
import 'sections/ecosystem_state_board_action_bar_section.dart';

class EcosystemStateBoardScreen extends StatelessWidget {
  const EcosystemStateBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'ecosystem_state_board',
      title: 'Ecosystem State Board',
      child: Column(
        children: const [
          const EcosystemStateBoardHeaderSection(),
          const EcosystemStateBoardContentSummarySection(),
          const EcosystemStateBoardPrimaryContentSection(),
          const EcosystemStateBoardActionBarSection(),
        ],
      ),
    );
  }
}
