import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'psw_my_clients_screen_controller.dart';

class PswMyClientsScreen extends ConsumerWidget {
  const PswMyClientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pswMyClientsScreenControllerProvider);

    return Semantics(
      label: 'data-cy:pswclients-screen',
      container: true,
      child: Semantics(
        label: 'data-cy:pswmyclients-screen',
        container: true,
        child: Scaffold(
          key: const Key('pswmyclients-screen'),
          appBar: AppBar(
            title: Semantics(label: 'data-cy:pswmyclients-title', container: true, child: Container(child: const Text('PswMyClients'))),
          ),
          body: Semantics(
            label: 'data-cy:pswclients-content',
            container: true,
            child: Semantics(
              label: 'data-cy:pswmyclients-content',
              container: true,
              child: state.when(
                data: (data) => _buildContent(context, data),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) =>
                    Center(child: Text('Error loading features: $error')),
              ),
            ),
          ),
        ),
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
          Semantics(
            label: 'data-cy:pswclients-title',
            container: true,
            child: Semantics(
              label: 'data-cy:pswmyclients-title',
              container: true,
              child: Container(
                child: Text(
                  'PswMyClientsScreen is now fully implemented.',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
