import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_my_clients_header_section.dart';
import 'sections/psw_my_clients_content_summary_section.dart';
import 'sections/psw_my_clients_primary_content_section.dart';
import 'sections/psw_my_clients_action_bar_section.dart';

class PswMyClientsScreen extends StatelessWidget {
  const PswMyClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_my_clients',
      title: 'Psw My Clients',
      child: Column(
        children: const [
          const PswMyClientsHeaderSection(),
          const PswMyClientsContentSummarySection(),
          const PswMyClientsPrimaryContentSection(),
          const PswMyClientsActionBarSection(),
        ],
      ),
    );
  }
}
