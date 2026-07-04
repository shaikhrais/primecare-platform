import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/prime_care_header_section.dart';
import 'sections/prime_care_content_summary_section.dart';
import 'sections/prime_care_primary_content_section.dart';
import 'sections/prime_care_action_bar_section.dart';

class PrimeCareScreen extends StatelessWidget {
  const PrimeCareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'prime_care',
      title: 'Prime Care',
      child: Column(
        children: const [
          const PrimeCareHeaderSection(),
          const PrimeCareContentSummarySection(),
          const PrimeCarePrimaryContentSection(),
          const PrimeCareActionBarSection(),
        ],
      ),
    );
  }
}
