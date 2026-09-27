import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'scheduler_analytics_screen_controller.dart';
import 'sections/scheduler_analytics_header_section.dart';
import 'sections/scheduler_analytics_calendar_controls_section.dart';
import 'sections/scheduler_analytics_schedule_list_section.dart';
import 'sections/scheduler_analytics_appointment_details_section.dart';
import 'sections/scheduler_analytics_action_bar_section.dart';


class SchedulerAnalyticsScreen extends ConsumerWidget {
  const SchedulerAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scheduler_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('SchedulerAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(scheduler_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('scheduler_analytics_loading'), child: Semantics(label: 'scheduler_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('scheduler_analytics_screen'),
                    child: Column(
                      children: [
                        SchedulerAnalyticsHeaderSection(data: state.data),
                        SchedulerAnalyticsCalendarControlsSection(data: state.data),
                        SchedulerAnalyticsScheduleListSection(data: state.data),
                        SchedulerAnalyticsAppointmentDetailsSection(data: state.data),
                        SchedulerAnalyticsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
