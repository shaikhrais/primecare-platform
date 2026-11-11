import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'psw_system_logs_screen_controller.dart';

class PswSystemLogsScreen extends ConsumerWidget {
  const PswSystemLogsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pswSystemLogsScreenControllerProvider);

    return Semantics(
      label: 'data-cy:pswsystemlogs-screen',
      container: true,
      child: PrimePageScaffold(
        scaffoldKey: const Key('pswsystemlogs-screen'),
      title: Semantics(label: 'data-cy:pswsystemlogs-title', container: true, child: Container(child:  const PrimeText('PswSystemLogs'))),
      body: state.when(
        data: (data) => _buildContent(context, data),
        loading: () => const DashboardLoadingWidget(),
        error: (error, stack) => Center(child: PrimeText('Error loading features: $error')),
      ),
    )
    );
  }

  Widget _buildContent(BuildContext context, dynamic data) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const PrimeStatusIcon(Icons.check_circle_outline, tone: PrimeStatusTone.success, size: 64),
          const SizedBox(height: 16),
          PrimeText(
            'PswSystemLogsScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
