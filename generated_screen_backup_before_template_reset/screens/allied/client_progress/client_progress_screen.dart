import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/client_progress_header_section.dart';
import 'sections/client_progress_content_summary_section.dart';
import 'sections/client_progress_primary_content_section.dart';
import 'sections/client_progress_action_bar_section.dart';

class ClientProgressScreen extends StatelessWidget {
  const ClientProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'client_progress',
      title: 'ClientProgressScreen',
      child: Column(
        children: const [
          const ClientProgressHeaderSection(),
          const ClientProgressContentSummarySection(),
          const ClientProgressPrimaryContentSection(),
          const ClientProgressActionBarSection(),
        ],
      ),
    );
  }
}
