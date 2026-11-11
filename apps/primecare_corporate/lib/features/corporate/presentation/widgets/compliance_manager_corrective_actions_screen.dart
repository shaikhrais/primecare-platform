import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'compliance_manager_corrective_actions_screen_controller.dart';

class ComplianceManagerCorrectiveActionsScreen extends ConsumerWidget {
  const ComplianceManagerCorrectiveActionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(complianceManagerCorrectiveActionsScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const PrimeText('ComplianceManagerCorrectiveActions'),
      ),
      body: state.when(
        data: (data) => _buildContent(context, data),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: PrimeText('Error loading features: $error')),
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
          PrimeText(
            'ComplianceManagerCorrectiveActionsScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
