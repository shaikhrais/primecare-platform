import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/booking_header_section.dart';
import 'sections/booking_content_summary_section.dart';
import 'sections/booking_primary_content_section.dart';
import 'sections/booking_action_bar_section.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'booking',
      title: 'BookingScreen',
      child: Column(
        children: const [
          const BookingHeaderSection(),
          const BookingContentSummarySection(),
          const BookingPrimaryContentSection(),
          const BookingActionBarSection(),
        ],
      ),
    );
  }
}
