import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/client_intake_header_section.dart';
import 'sections/client_intake_content_summary_section.dart';
import 'sections/client_intake_primary_content_section.dart';
import 'sections/client_intake_action_bar_section.dart';

class ClientIntakeScreen extends StatelessWidget {
  const ClientIntakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'client_intake',
      title: 'ClientIntakeScreen',
      child: Column(
        children: const [
          const ClientIntakeHeaderSection(),
          const ClientIntakeContentSummarySection(),
          const ClientIntakePrimaryContentSection(),
          const ClientIntakeActionBarSection(),
        ],
      ),
    );
  }
}
