import 'package:primecare_ui/primecare_ui.dart';
import 'corporate_operations_controller.dart';

class CeoDashboardView extends ConsumerWidget {
  const CeoDashboardView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(corporateDashboardControllerProvider('ceo'));
    return PageTemplate(
      title: 'CEO Strategic Command',
      subtitle: 'Enterprise-wide performance surveillance.',
      bodySections: [
        state.when(
          data: (model) => AssemblyLine(blueprints: model.blueprints),
          loading: () => const LoadingState(),
          error: (err, st) => ErrorState(message: err.toString()),
        ),
      ],
    );
  }
}

class CfoDashboardView extends ConsumerWidget {
  const CfoDashboardView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(corporateDashboardControllerProvider('cfo'));
    return PageTemplate(
      title: 'CFO Financial Hub',
      subtitle: 'Fiscal health and revenue tracking.',
      bodySections: [
        state.when(
          data: (model) => AssemblyLine(blueprints: model.blueprints),
          loading: () => const LoadingState(),
          error: (err, st) => ErrorState(message: err.toString()),
        ),
      ],
    );
  }
}

class CooDashboardView extends ConsumerWidget {
  const CooDashboardView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(corporateDashboardControllerProvider('coo'));
    return PageTemplate(
      title: 'COO Operations Board',
      subtitle: 'Operational efficiency and branch metrics.',
      bodySections: [
        state.when(
          data: (model) => AssemblyLine(blueprints: model.blueprints),
          loading: () => const LoadingState(),
          error: (err, st) => ErrorState(message: err.toString()),
        ),
      ],
    );
  }
}

class CtoDashboardView extends ConsumerWidget {
  const CtoDashboardView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(corporateDashboardControllerProvider('cto'));
    return PageTemplate(
      title: 'CTO Technology Matrix',
      subtitle: 'System health and API performance.',
      bodySections: [
        state.when(
          data: (model) => AssemblyLine(blueprints: model.blueprints),
          loading: () => const LoadingState(),
          error: (err, st) => ErrorState(message: err.toString()),
        ),
      ],
    );
  }
}

class VerificationHubView extends ConsumerWidget {
  const VerificationHubView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => const PageTemplate(
    title: 'Verification Hub',
    subtitle: 'System integrity and audit dashboard.',
    bodySections: [PrimeCard(child: Center(child: Text('Verification Hub Content')))],
  );
}
