import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/chiropractor_client_intake_header_section.dart';
import 'sections/chiropractor_client_intake_content_summary_section.dart';
import 'sections/chiropractor_client_intake_primary_content_section.dart';
import 'sections/chiropractor_client_intake_action_bar_section.dart';

class ChiropractorClientIntakeScreen extends StatelessWidget {
  const ChiropractorClientIntakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'chiropractor_client_intake',
      title: 'ChiropractorClientIntakeScreen',
      child: Column(
        children: const [
          const ChiropractorClientIntakeHeaderSection(),
          const ChiropractorClientIntakeContentSummarySection(),
          const ChiropractorClientIntakePrimaryContentSection(),
          const ChiropractorClientIntakeActionBarSection(),
        ],
      ),
    );
  }
}
