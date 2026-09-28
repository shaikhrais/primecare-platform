import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_check_in_header_section.dart';
import 'sections/psw_check_in_content_summary_section.dart';
import 'sections/psw_check_in_primary_content_section.dart';
import 'sections/psw_check_in_action_bar_section.dart';

class PswCheckInScreen extends StatelessWidget {
  const PswCheckInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_check_in',
      title: 'Psw Check In',
      child: Column(
        children: const [
          const PswCheckInHeaderSection(),
          const PswCheckInContentSummarySection(),
          const PswCheckInPrimaryContentSection(),
          const PswCheckInActionBarSection(),
        ],
      ),
    );
  }
}
