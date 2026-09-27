import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'booking_screen_controller.dart';
import 'sections/booking_header_section.dart';
import 'sections/booking_content_summary_section.dart';
import 'sections/booking_primary_content_section.dart';
import 'sections/booking_action_bar_section.dart';


class BookingScreen extends ConsumerWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bookingControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Booking'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(bookingControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('booking_loading'), child: Semantics(label: 'booking_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('booking_screen'),
                    child: Column(
                      children: [
                        BookingHeaderSection(data: state.data),
                        BookingContentSummarySection(data: state.data),
                        BookingPrimaryContentSection(data: state.data),
                        BookingActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
