import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/local_marketing_manager_content_calendar_header_section.dart';
import 'sections/local_marketing_manager_content_calendar_calendar_controls_section.dart';
import 'sections/local_marketing_manager_content_calendar_schedule_list_section.dart';
import 'sections/local_marketing_manager_content_calendar_appointment_details_section.dart';
import 'sections/local_marketing_manager_content_calendar_action_bar_section.dart';

class LocalMarketingManagerContentCalendarScreen extends StatelessWidget {
  const LocalMarketingManagerContentCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'local_marketing_manager_content_calendar',
      title: 'Local Marketing Manager Content Calendar',
      child: Column(
        children: const [
          const LocalMarketingManagerContentCalendarHeaderSection(),
          const LocalMarketingManagerContentCalendarCalendarControlsSection(),
          const LocalMarketingManagerContentCalendarScheduleListSection(),
          const LocalMarketingManagerContentCalendarAppointmentDetailsSection(),
          const LocalMarketingManagerContentCalendarActionBarSection(),
        ],
      ),
    );
  }
}
