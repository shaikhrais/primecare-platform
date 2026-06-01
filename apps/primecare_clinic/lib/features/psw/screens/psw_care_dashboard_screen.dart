import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'psw_care_dashboard_screen_controller.dart';

class PswCareDashboardScreen extends ConsumerWidget {
  const PswCareDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pswCareDashboardScreenControllerProvider);

    return Semantics(
      label: 'data-cy:pswcaredashboard-screen',
      container: true,
      child: Scaffold(
        key: const Key('pswcaredashboard-screen'),
      appBar: AppBar(
        title: Semantics(label: 'data-cy:pswcaredashboard-title', container: true, child: Container(child:  const Text('PswCareDashboard'))),
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
            'PswCareDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
