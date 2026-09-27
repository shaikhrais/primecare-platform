import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/physiotherapist_client_intake_header_section.dart';
import 'sections/physiotherapist_client_intake_content_summary_section.dart';
import 'sections/physiotherapist_client_intake_primary_content_section.dart';
import 'sections/physiotherapist_client_intake_action_bar_section.dart';

class PhysiotherapistClientIntakeScreen extends StatelessWidget {
  const PhysiotherapistClientIntakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'physiotherapist_client_intake',
      title: 'PhysiotherapistClientIntakeScreen',
      child: Column(
        children: const [
          const PhysiotherapistClientIntakeHeaderSection(),
          const PhysiotherapistClientIntakeContentSummarySection(),
          const PhysiotherapistClientIntakePrimaryContentSection(),
          const PhysiotherapistClientIntakeActionBarSection(),
        ],
      ),
    );
  }
}
