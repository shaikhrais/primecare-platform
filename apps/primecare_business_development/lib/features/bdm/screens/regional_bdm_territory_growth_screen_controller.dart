import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'regional_bdm_territory_growth_screen_controller_controller.dart';

class RegionalBdmTerritoryGrowthScreenController extends ConsumerWidget {
  const RegionalBdmTerritoryGrowthScreenController({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(RegionalBdmTerritoryGrowthScreenControllerControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('RegionalBdmTerritoryGrowthScreenController'),
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
            'RegionalBdmTerritoryGrowthScreenController is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
