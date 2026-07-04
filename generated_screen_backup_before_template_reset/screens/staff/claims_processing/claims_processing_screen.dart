import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/claims_processing_header_section.dart';
import 'sections/claims_processing_content_summary_section.dart';
import 'sections/claims_processing_primary_content_section.dart';
import 'sections/claims_processing_action_bar_section.dart';

class ClaimsProcessingScreen extends StatelessWidget {
  const ClaimsProcessingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'claims_processing',
      title: 'ClaimsProcessingScreen',
      child: Column(
        children: const [
          const ClaimsProcessingHeaderSection(),
          const ClaimsProcessingContentSummarySection(),
          const ClaimsProcessingPrimaryContentSection(),
          const ClaimsProcessingActionBarSection(),
        ],
      ),
    );
  }
}
