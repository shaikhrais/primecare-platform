import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_shift_tracker_header_section.dart';
import 'sections/psw_shift_tracker_calendar_controls_section.dart';
import 'sections/psw_shift_tracker_schedule_list_section.dart';
import 'sections/psw_shift_tracker_appointment_details_section.dart';
import 'sections/psw_shift_tracker_action_bar_section.dart';

class PswShiftTrackerScreen extends StatelessWidget {
  const PswShiftTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_shift_tracker',
      title: 'Shift Tracker',
      child: Column(
        children: const [
          const PswShiftTrackerHeaderSection(),
          const PswShiftTrackerCalendarControlsSection(),
          const PswShiftTrackerScheduleListSection(),
          const PswShiftTrackerAppointmentDetailsSection(),
          const PswShiftTrackerActionBarSection(),
        ],
      ),
    );
  }
}

typedef ShiftTrackerScreen = PswShiftTrackerScreen;
