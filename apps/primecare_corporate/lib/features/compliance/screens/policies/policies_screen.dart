import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/policies_header_section.dart';
import 'sections/policies_content_summary_section.dart';
import 'sections/policies_primary_content_section.dart';
import 'sections/policies_action_bar_section.dart';

class PoliciesScreen extends StatelessWidget {
  const PoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'policies',
      title: 'Policies',
      child: Column(
        children: const [
          const PoliciesHeaderSection(),
          const PoliciesContentSummarySection(),
          const PoliciesPrimaryContentSection(),
          const PoliciesActionBarSection(),
        ],
      ),
    );
  }
}
