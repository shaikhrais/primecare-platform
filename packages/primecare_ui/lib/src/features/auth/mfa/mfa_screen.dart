import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/mfa_header_section.dart';
import 'sections/mfa_content_summary_section.dart';
import 'sections/mfa_primary_content_section.dart';
import 'sections/mfa_action_bar_section.dart';

class MfaScreen extends StatelessWidget {
  const MfaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'mfa',
      title: 'Mfa',
      child: Column(
        children: const [
          const MfaHeaderSection(),
          const MfaContentSummarySection(),
          const MfaPrimaryContentSection(),
          const MfaActionBarSection(),
        ],
      ),
    );
  }
}
