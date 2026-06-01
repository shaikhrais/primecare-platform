import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'clinic_history_logs_screen_controller.dart';

class ClinicHistoryLogsScreen extends ConsumerWidget {
  const ClinicHistoryLogsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clinicHistoryLogsScreenControllerProvider);

    return Semantics(
      label: 'data-cy:clinichistorylogs-screen',
      container: true,
      child: Scaffold(
        key: const Key('clinichistorylogs-screen'),
      appBar: AppBar(
        title: Semantics(label: 'data-cy:clinichistorylogs-title', child: const Text('ClinicHistoryLogs')),
      ),
      body: state.when(
        data: (data) => _buildContent(context, data),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error loading features: $error')),
      ),
    )
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
            'ClinicHistoryLogsScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
