import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_clients_header_section.dart';
import 'sections/psw_clients_identity_summary_section.dart';
import 'sections/psw_clients_details_form_section.dart';
import 'sections/psw_clients_preferences_or_documents_section.dart';
import 'sections/psw_clients_action_bar_section.dart';

class PswClientsScreen extends StatelessWidget {
  const PswClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_clients',
      title: 'My Clients',
      child: Column(
        children: const [
          const PswClientsHeaderSection(),
          const PswClientsIdentitySummarySection(),
          const PswClientsDetailsFormSection(),
          const PswClientsPreferencesOrDocumentsSection(),
          const PswClientsActionBarSection(),
        ],
      ),
    );
  }
}

typedef MyClientsScreen = PswClientsScreen;
