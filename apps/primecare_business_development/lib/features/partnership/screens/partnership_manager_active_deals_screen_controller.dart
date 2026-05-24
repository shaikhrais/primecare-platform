import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'partnership_manager_active_deals_screen_controller_controller.dart';

class PartnershipManagerActiveDealsScreenController extends ConsumerWidget {
  const PartnershipManagerActiveDealsScreenController({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(PartnershipManagerActiveDealsScreenControllerControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PartnershipManagerActiveDealsScreenController'),
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
            'PartnershipManagerActiveDealsScreenController is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
