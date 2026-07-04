import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/client_care_team_header_section.dart';
import 'sections/client_care_team_content_summary_section.dart';
import 'sections/client_care_team_primary_content_section.dart';
import 'sections/client_care_team_action_bar_section.dart';

class ClientCareTeamScreen extends StatelessWidget {
  const ClientCareTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'client_care_team',
      title: 'Client Care Team',
      child: Column(
        children: const [
          const ClientCareTeamHeaderSection(),
          const ClientCareTeamContentSummarySection(),
          const ClientCareTeamPrimaryContentSection(),
          const ClientCareTeamActionBarSection(),
        ],
      ),
    );
  }
}
