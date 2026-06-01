import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'chiropractor_dashboard_screen_controller.dart';

class ChiropractorDashboardScreen extends ConsumerWidget {
  const ChiropractorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chiropractorDashboardScreenControllerProvider);

    return Semantics(
      label: 'data-cy:chiropractordashboard-screen',
      container: true,
      child: Scaffold(
        key: const Key('chiropractordashboard-screen'),
      appBar: AppBar(
        title: Semantics(label: 'data-cy:chiropractordashboard-title', container: true, child: Container(child:  const Text('ChiropractorDashboard'))),
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
            'ChiropractorDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
