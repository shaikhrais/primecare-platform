import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rmt_client_intake_header_section.dart';
import 'sections/rmt_client_intake_content_summary_section.dart';
import 'sections/rmt_client_intake_primary_content_section.dart';
import 'sections/rmt_client_intake_action_bar_section.dart';

class RmtClientIntakeScreen extends StatelessWidget {
  const RmtClientIntakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rmt_client_intake',
      title: 'RmtClientIntakeScreen',
      child: Column(
        children: const [
          const RmtClientIntakeHeaderSection(),
          const RmtClientIntakeContentSummarySection(),
          const RmtClientIntakePrimaryContentSection(),
          const RmtClientIntakeActionBarSection(),
        ],
      ),
    );
  }
}
