// Governance - Category: view | Purpose: UI Screen component rendering the Psw My Clients workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- State Model ---
class PswMyClientsState {
  final List<Map<String, String>> clients;
  final String query;

  const PswMyClientsState({
    required this.clients,
    required this.query,
  });

  PswMyClientsState copyWith({
    List<Map<String, String>>? clients,
    String? query,
  }) {
    return PswMyClientsState(
      clients: clients ?? this.clients,
      query: query ?? this.query,
    );
  }
}

// --- Controller ---
class PswMyClientsController extends StateNotifier<PswMyClientsState> {
  final Ref _ref;
  PswMyClientsController(this._ref)
      : super(const PswMyClientsState(
          query: '',
          clients: [
            {'id': '1', 'name': 'Margaret Thompson', 'age': '79', 'status': 'Active Care'},
            {'id': '2', 'name': 'Arthur Pendelton', 'age': '84', 'status': 'Active Care'},
            {'id': '3', 'name': 'Eleanor Vance', 'age': '72', 'status': 'Shift Complete'},
          ],
        ));

  void searchClient(String val) {
    state = state.copyWith(query: val);
  }

  void accessClientDocuments() {
    print('Governance action: accessClientDocuments executed.');
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
        route: '/psw/my/clients',
        eventType: 'accessClientDocuments',
        metadata: {'action': 'document_view'},
      );
    } catch (_) {}
  }
}

final pswMyClientsControllerProvider = StateNotifierProvider<PswMyClientsController, PswMyClientsState>((ref) {
  return PswMyClientsController(ref);
});

// --- View ---
class PswMyClientsScreen extends GovernedConsumerWidget {
  const PswMyClientsScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(pswMyClientsControllerProvider);
    final controller = ref.read(pswMyClientsControllerProvider.notifier);

    final filtered = state.clients
        .where((c) => c['name']!.toLowerCase().contains(state.query.toLowerCase()))
        .toList();

    return Semantics(
      label: 'data-cy:clientlist-view',
      container: true,
      child: Scaffold(
        key: const Key('clientlist-view'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Text(
            'My Active Clients',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
        ),
        body: Semantics(
          label: 'data-cy:pswmyclients-content',
          container: true,
          child: SingleChildScrollView(
            key: const Key('pswmyclients-content'),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusSm),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: TextField(
                    key: const Key('clientsearch-bar'),
                    decoration: const InputDecoration(
                      hintText: 'Search clients by name...',
                      border: InputBorder.none,
                      icon: Icon(LucideIcons.search, size: 18),
                    ),
                    onChanged: (val) => controller.searchClient(val),
                  ),
                ),
                const SizedBox(height: 24),

                // Clients List
                Text('Active Clients (${filtered.length})', style: theme.typography.h4.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                ...filtered.map((c) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusSm),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c['name'] ?? '', style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('Age: ${c['age']} | ${c['status']}', style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                        ],
                      ),
                      ElevatedButton(
                        key: const Key('clientactivity-log'),
                        onPressed: () => controller.accessClientDocuments(),
                        child: const Text('Access Docs'),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
