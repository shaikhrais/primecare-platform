import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'scheduler_compliance_screen_controller.dart';
import 'sections/scheduler_compliance_header_section.dart';
import 'sections/scheduler_compliance_calendar_controls_section.dart';
import 'sections/scheduler_compliance_schedule_list_section.dart';
import 'sections/scheduler_compliance_appointment_details_section.dart';
import 'sections/scheduler_compliance_action_bar_section.dart';


class SchedulerComplianceScreen extends ConsumerWidget {
  const SchedulerComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scheduler_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('SchedulerCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(scheduler_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('scheduler_compliance_loading'), child: Semantics(label: 'scheduler_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('scheduler_compliance_screen'),
                    child: Column(
                      children: [
                        SchedulerComplianceHeaderSection(data: state.data),
                        SchedulerComplianceCalendarControlsSection(data: state.data),
                        SchedulerComplianceScheduleListSection(data: state.data),
                        SchedulerComplianceAppointmentDetailsSection(data: state.data),
                        SchedulerComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
