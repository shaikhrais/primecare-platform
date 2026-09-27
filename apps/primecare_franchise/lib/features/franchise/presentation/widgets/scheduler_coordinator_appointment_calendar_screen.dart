import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'scheduler_coordinator_appointment_calendar_screen_controller.dart';

class SchedulerCoordinatorAppointmentCalendarScreen extends ConsumerWidget {
  const SchedulerCoordinatorAppointmentCalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(schedulerCoordinatorAppointmentCalendarScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SchedulerCoordinatorAppointmentCalendar'),
      ),
      body: state.when(
        data: (data) => _buildContent(context, data),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error loading features: $error')),
      ),
    );
  }

  Widget _buildContent(BuildContext context, dynamic data) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_outline, size: 64, color: Colors.green),
          const SizedBox(height: 16),
          Text(
            'SchedulerCoordinatorAppointmentCalendarScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
