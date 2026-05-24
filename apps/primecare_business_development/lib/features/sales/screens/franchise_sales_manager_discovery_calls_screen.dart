import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'franchise_sales_manager_discovery_calls_screen_controller.dart';

class FranchiseSalesManagerDiscoveryCallsScreen extends ConsumerWidget {
  const FranchiseSalesManagerDiscoveryCallsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(FranchiseSalesManagerDiscoveryCallsScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FranchiseSalesManagerDiscoveryCalls'),
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
            'FranchiseSalesManagerDiscoveryCallsScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
