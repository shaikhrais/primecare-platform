import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_hiring_credentials_header_section.dart';
import 'sections/hr_hiring_credentials_content_summary_section.dart';
import 'sections/hr_hiring_credentials_primary_content_section.dart';
import 'sections/hr_hiring_credentials_action_bar_section.dart';

class HrHiringCredentialsScreen extends StatelessWidget {
  const HrHiringCredentialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_hiring_credentials',
      title: 'HrHiringCredentialsScreen',
      child: Column(
        children: const [
          const HrHiringCredentialsHeaderSection(),
          const HrHiringCredentialsContentSummarySection(),
          const HrHiringCredentialsPrimaryContentSection(),
          const HrHiringCredentialsActionBarSection(),
        ],
      ),
    );
  }
}
