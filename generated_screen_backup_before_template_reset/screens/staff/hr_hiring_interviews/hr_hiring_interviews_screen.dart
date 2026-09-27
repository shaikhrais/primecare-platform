import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_hiring_interviews_header_section.dart';
import 'sections/hr_hiring_interviews_filter_bar_section.dart';
import 'sections/hr_hiring_interviews_data_table_section.dart';
import 'sections/hr_hiring_interviews_pagination_section.dart';
import 'sections/hr_hiring_interviews_action_bar_section.dart';

class HrHiringInterviewsScreen extends StatelessWidget {
  const HrHiringInterviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_hiring_interviews',
      title: 'HrHiringInterviewsScreen',
      child: Column(
        children: const [
          const HrHiringInterviewsHeaderSection(),
          const HrHiringInterviewsFilterBarSection(),
          const HrHiringInterviewsDataTableSection(),
          const HrHiringInterviewsPaginationSection(),
          const HrHiringInterviewsActionBarSection(),
        ],
      ),
    );
  }
}
