import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_my_shifts_header_section.dart';
import 'sections/psw_my_shifts_content_summary_section.dart';
import 'sections/psw_my_shifts_primary_content_section.dart';
import 'sections/psw_my_shifts_action_bar_section.dart';

class PswMyShiftsScreen extends StatelessWidget {
  const PswMyShiftsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_my_shifts',
      title: 'Psw My Shifts',
      child: Column(
        children: const [
          const PswMyShiftsHeaderSection(),
          const PswMyShiftsContentSummarySection(),
          const PswMyShiftsPrimaryContentSection(),
          const PswMyShiftsActionBarSection(),
        ],
      ),
    );
  }
}
