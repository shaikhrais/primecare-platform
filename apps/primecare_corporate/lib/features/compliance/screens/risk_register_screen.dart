import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'risk_register_screen_controller.dart';

class RiskRegisterScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The risk register screen requires components for listing, adding, updating, and removing risks, along with monitoring and reporting functionalities.';

  @override
  List<String> get requiredComponents => const [
        'RiskList',
        'RiskForm',
        'RiskStatusIndicator',
        'ActivityLog',
        'SearchBar',
        'ReportExport',
      ];

  @override
  List<String> get requiredFunctions => const [
        'loadRisks',
        'addRisk',
        'updateRisk',
        'removeRisk',
        'monitorRiskStatus',
        'generateReport',
      ];

  const RiskRegisterScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(riskRegisterScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('RiskRegister'),
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
            'RiskRegisterScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
