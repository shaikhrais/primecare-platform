import 'package:primecare_ui/primecare_ui.dart';
import 'clinic_operations_controller.dart';

class ClinicDashboardView extends ConsumerWidget {
  const ClinicDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clinicDashboardControllerProvider);
    return PageTemplate(
      title: 'Clinical Dashboard',
      subtitle: 'Real-time operational surveillance.',
      bodySections: [
        state.when(
          data: (result) => result.fold(
            (data) => AssemblyLine(
              blueprints: data.blueprints,
              isOfflineFallback: data.isOfflineFallback,
            ),
            (error) => ErrorState(message: error.toString()),
          ),
          loading: () => const LoadingState(),
          error: (err, st) => ErrorState(message: err.toString()),
        ),
      ],
    );
  }
}

class CarePlanView extends ConsumerWidget {
  const CarePlanView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => const PageTemplate(
    title: 'Care Plan',
    subtitle: 'Review and update client care plans.',
    bodySections: [PrimeCard(child: Center(child: Text('Care Plan Content')))],
  );
}

class CheckInOutView extends ConsumerWidget {
  const CheckInOutView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => const PageTemplate(
    title: 'Check-In / Out',
    subtitle: 'Log time and attendance.',
    bodySections: [PrimeCard(child: Center(child: Text('Check-In / Out Content')))],
  );
}

class ClientProfileView extends ConsumerWidget {
  const ClientProfileView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => const PageTemplate(
    title: 'Client Profile',
    subtitle: 'View and manage client details.',
    bodySections: [PrimeCard(child: Center(child: Text('Client Profile Content')))],
  );
}

class DailyNotesView extends ConsumerWidget {
  const DailyNotesView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => const PageTemplate(
    title: 'Daily Notes',
    subtitle: 'Document daily observations.',
    bodySections: [PrimeCard(child: Center(child: Text('Daily Notes Content')))],
  );
}

class HistoryLogsView extends ConsumerWidget {
  const HistoryLogsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => const PageTemplate(
    title: 'History & Logs',
    subtitle: 'Audit logs and past interactions.',
    bodySections: [PrimeCard(child: Center(child: Text('History & Logs Content')))],
  );
}

class IncidentReportView extends ConsumerWidget {
  const IncidentReportView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => const PageTemplate(
    title: 'Incident Report',
    subtitle: 'File reports for any incidents.',
    bodySections: [PrimeCard(child: Center(child: Text('Incident Report Content')))],
  );
}

class MessagingView extends ConsumerWidget {
  const MessagingView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => const PageTemplate(
    title: 'Messaging',
    subtitle: 'Secure communications.',
    bodySections: [PrimeCard(child: Center(child: Text('Messaging Content')))],
  );
}

class MyShiftsView extends ConsumerWidget {
  const MyShiftsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => const PageTemplate(
    title: 'My Shifts',
    subtitle: 'Manage your assigned shifts.',
    bodySections: [PrimeCard(child: Center(child: Text('My Shifts Content')))],
  );
}

class ProfileSettingsView extends ConsumerWidget {
  const ProfileSettingsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => const PageTemplate(
    title: 'Profile & Settings',
    subtitle: 'Manage user preferences.',
    bodySections: [PrimeCard(child: Center(child: Text('Profile & Settings Content')))],
  );
}

class ShiftDetailsView extends ConsumerWidget {
  const ShiftDetailsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => const PageTemplate(
    title: 'Shift Details',
    subtitle: 'View upcoming and active shifts.',
    bodySections: [PrimeCard(child: Center(child: Text('Shift Details Content')))],
  );
}
