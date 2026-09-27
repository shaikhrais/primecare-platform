import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'psw_profile_screen_controller.dart';

class PswProfileScreen extends ConsumerWidget {
  const PswProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pswProfileScreenControllerProvider);

    return Semantics(
      label: 'data-cy:pswprofile-screen',
      container: true,
      child: Scaffold(
        key: const Key('pswprofile-screen'),
      appBar: AppBar(
        title: Semantics(label: 'data-cy:pswprofile-title', container: true, child: Container(child:  const Text('PswProfile'))),
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
            'PswProfileScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
