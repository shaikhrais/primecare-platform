import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/intake_coordinator_booking_header_section.dart';
import 'sections/intake_coordinator_booking_content_summary_section.dart';
import 'sections/intake_coordinator_booking_primary_content_section.dart';
import 'sections/intake_coordinator_booking_action_bar_section.dart';

class IntakeCoordinatorBookingScreen extends StatelessWidget {
  const IntakeCoordinatorBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'intake_coordinator_booking',
      title: 'IntakeCoordinatorBookingScreen',
      child: Column(
        children: const [
          const IntakeCoordinatorBookingHeaderSection(),
          const IntakeCoordinatorBookingContentSummarySection(),
          const IntakeCoordinatorBookingPrimaryContentSection(),
          const IntakeCoordinatorBookingActionBarSection(),
        ],
      ),
    );
  }
}
