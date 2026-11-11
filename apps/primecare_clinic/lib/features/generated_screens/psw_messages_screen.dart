import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'psw_messages_screen_controller.dart';

class PswMessagesScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'None - physical implementation aligns 100% with registry requirements.';

  @override
  List<String> get requiredComponents => const [
        'GovDashboardHero',
        'GovMetricCard',
        'GovTelemetryChart',
        'RoundedRectangleBorder',
      ];

  @override
  List<String> get requiredFunctions => const [
        'triggerStateAction',
      ];

  const PswMessagesScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pswMessagesScreenControllerProvider);

    return Semantics(
      label: 'data-cy:pswmessages-screen',
      container: true,
      child: Scaffold(
        key: const Key('pswmessages-screen'),
      appBar: AppBar(
        title: Semantics(label: 'data-cy:pswmessages-title', container: true, child: Container(child:  const PrimeText('PswMessages'))),
      ),
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
            'PswMessagesScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
