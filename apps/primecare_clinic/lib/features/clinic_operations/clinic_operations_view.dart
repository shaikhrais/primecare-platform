import 'package:primecare_ui/primecare_ui.dart';
import 'clinic_operations_model.dart';
import 'clinic_operations_controller.dart';

class ClinicOperationsView extends ConsumerWidget {
  const ClinicOperationsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clinicDashboardControllerProvider);

    return state.when(
      data: (result) => result.fold(
        (model) => _buildDashboard(context, model),
        (error) => DashboardErrorWidget(message: error.toString(), onRetry: () {}),
      ),
      loading: () => const DashboardLoadingWidget(),
      error: (e, s) => DashboardErrorWidget(message: e.toString(), onRetry: () {}),
    );
  }

  Widget _buildDashboard(BuildContext context, dynamic m) {
    final model = m as ClinicOperationsModel;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: DashboardKpiGrid(metrics: model.metrics),
        ),
        const SliverPadding(padding: EdgeInsets.all(16)),
        SliverToBoxAdapter(
          child: PrimeCareCard(
            child: SizedBox(
              height: 200,
              child: Center(child: Text('Analytics Charts Placeholder')),
            ),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.all(16)),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ActionableInsightCard(
              insight: model.insights[index],
            ),
            childCount: model.insights.length,
          ),
        ),
      ],
    );
  }
}

class CarePlanView extends ConsumerWidget {
  const CarePlanView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => const CustomScrollView(slivers: [
    SliverToBoxAdapter(child: PrimeCareCard(child: Center(child: Text('Care Plan Content'))))
  ]);
}

class CheckInOutView extends ConsumerWidget {
  const CheckInOutView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => const CustomScrollView(slivers: [
    SliverToBoxAdapter(child: PrimeCareCard(child: Center(child: Text('Check-In / Out Content'))))
  ]);
}

class ClientProfileView extends ConsumerWidget {
  const ClientProfileView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => const CustomScrollView(slivers: [
    SliverToBoxAdapter(child: PrimeCareCard(child: Center(child: Text('Client Profile Content'))))
  ]);
}

class DailyNotesView extends ConsumerWidget {
  const DailyNotesView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => const CustomScrollView(slivers: [
    SliverToBoxAdapter(child: PrimeCareCard(child: Center(child: Text('Daily Notes Content'))))
  ]);
}

class HistoryLogsView extends ConsumerWidget {
  const HistoryLogsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => const CustomScrollView(slivers: [
    SliverToBoxAdapter(child: PrimeCareCard(child: Center(child: Text('History & Logs Content'))))
  ]);
}

class IncidentReportView extends ConsumerWidget {
  const IncidentReportView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => const CustomScrollView(slivers: [
    SliverToBoxAdapter(child: PrimeCareCard(child: Center(child: Text('Incident Report Content'))))
  ]);
}

class MessagingView extends ConsumerWidget {
  const MessagingView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => const CustomScrollView(slivers: [
    SliverToBoxAdapter(child: PrimeCareCard(child: Center(child: Text('Messaging Content'))))
  ]);
}

class MyShiftsView extends ConsumerWidget {
  const MyShiftsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => const CustomScrollView(slivers: [
    SliverToBoxAdapter(child: PrimeCareCard(child: Center(child: Text('My Shifts Content'))))
  ]);
}

class ProfileSettingsView extends ConsumerWidget {
  const ProfileSettingsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => const CustomScrollView(slivers: [
    SliverToBoxAdapter(child: PrimeCareCard(child: Center(child: Text('Profile & Settings Content'))))
  ]);
}

class ShiftDetailsView extends ConsumerWidget {
  const ShiftDetailsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => const CustomScrollView(slivers: [
    SliverToBoxAdapter(child: PrimeCareCard(child: Center(child: Text('Shift Details Content'))))
  ]);
}
