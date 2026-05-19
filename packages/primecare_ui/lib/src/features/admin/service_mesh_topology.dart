import 'package:primecare_ui/primecare_ui.dart';

final topologyProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/topology');
  return response.data is Map<String, dynamic> ? response.data as Map<String, dynamic> : {};
});

class ServiceMeshTopologyScreen extends GovernedConsumerWidget {
  const ServiceMeshTopologyScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(topologyProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Service Mesh Topology',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(topologyProvider),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load mesh topology: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (topology) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Live Cloudflare Worker Routing', style: theme.typography.h2),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.account_tree, size: 64, color: theme.colors.primary.withOpacity(0.5)),
                        const SizedBox(height: 16),
                        Text('Interactive Network Graph Component Placeholder', style: theme.typography.h4),
                        const SizedBox(height: 8),
                        Text('Nodes Active: ${topology['activeNodes'] ?? 0} | Routes: ${topology['activeRoutes'] ?? 0}', style: theme.typography.bodyMedium),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
