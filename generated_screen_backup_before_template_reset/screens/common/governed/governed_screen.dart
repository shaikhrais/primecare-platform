import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/governed_header_section.dart';
import 'sections/governed_content_summary_section.dart';
import 'sections/governed_primary_content_section.dart';
import 'sections/governed_action_bar_section.dart';

class GovernedScreen extends StatelessWidget {
  const GovernedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'governed',
      title: 'Governed',
      child: Column(
        children: const [
          const GovernedHeaderSection(),
          const GovernedContentSummarySection(),
          const GovernedPrimaryContentSection(),
          const GovernedActionBarSection(),
        ],
      ),
    );
  }
}
