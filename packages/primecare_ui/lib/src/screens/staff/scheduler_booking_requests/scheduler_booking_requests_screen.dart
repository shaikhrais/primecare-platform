import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'scheduler_booking_requests_screen_controller.dart';
import 'sections/scheduler_booking_requests_header_section.dart';
import 'sections/scheduler_booking_requests_form_body_section.dart';
import 'sections/scheduler_booking_requests_validation_messages_section.dart';
import 'sections/scheduler_booking_requests_action_bar_section.dart';


class SchedulerBookingRequestsScreen extends ConsumerWidget {
  const SchedulerBookingRequestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scheduler_booking_requestsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('SchedulerBookingRequests'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(scheduler_booking_requestsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('scheduler_booking_requests_loading'), child: Semantics(label: 'scheduler_booking_requests_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('scheduler_booking_requests_screen'),
                    child: Column(
                      children: [
                        SchedulerBookingRequestsHeaderSection(data: state.data),
                        SchedulerBookingRequestsFormBodySection(data: state.data),
                        SchedulerBookingRequestsValidationMessagesSection(data: state.data),
                        SchedulerBookingRequestsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
