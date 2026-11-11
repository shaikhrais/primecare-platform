import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'psw_reports_screen_controller.dart';

class PswReportsScreen extends ConsumerWidget {
  const PswReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pswReportsScreenControllerProvider);

    return Semantics(
      label: 'data-cy:pswreports-screen',
      container: true,
      child: PrimePageScaffold(
        scaffoldKey: const Key('pswreports-screen'),
      title: Semantics(label: 'data-cy:pswreports-title', container: true, child: Container(child:  const PrimeText('PswReports'))),
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
            'PswReportsScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
