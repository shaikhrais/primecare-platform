import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/remote_diagnosticser_header_section.dart';
import 'sections/remote_diagnosticser_content_summary_section.dart';
import 'sections/remote_diagnosticser_primary_content_section.dart';
import 'sections/remote_diagnosticser_action_bar_section.dart';

class RemoteDiagnosticserScreen extends StatelessWidget {
  const RemoteDiagnosticserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'remote_diagnosticser',
      title: 'Remote Diagnosticser',
      child: Column(
        children: const [
          const RemoteDiagnosticserHeaderSection(),
          const RemoteDiagnosticserContentSummarySection(),
          const RemoteDiagnosticserPrimaryContentSection(),
          const RemoteDiagnosticserActionBarSection(),
        ],
      ),
    );
  }
}
