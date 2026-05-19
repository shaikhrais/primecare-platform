import 'package:primecare_ui/primecare_ui.dart';

final leadPipelineProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/leads');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class LeadPipelineScreen extends GovernedConsumerWidget {
  const LeadPipelineScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final leadsState = ref.watch(leadPipelineProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Lead Pipeline',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: theme.colors.primary),
            onPressed: () {},
            tooltip: 'Add New Lead',
          ),
          IconButton(
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () {
              ref.invalidate(leadPipelineProvider);
            },
            tooltip: 'Refresh Pipeline',
          ),
        ],
      ),
      body: leadsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load leads: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (leads) {
          final stages = ['Prospect', 'Contacted', 'Negotiation', 'Closed Won', 'Closed Lost'];
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'B2B Franchise & Hospital Acquisition',
                  style: theme.typography.h2.copyWith(color: theme.colors.onBackground),
                ),
                const SizedBox(height: 24),
                // Kanban Board representation
                SizedBox(
                  height: 600,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: stages.length,
                    itemBuilder: (context, index) {
                      final stage = stages[index];
                      final stageLeads = leads.where((l) => l['status'] == stage).toList();
                      
                      return Container(
                        width: 320,
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          color: theme.colors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: theme.colors.border),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: theme.colors.background,
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
                                border: Border(bottom: BorderSide(color: theme.colors.border)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(stage, style: theme.typography.h4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: theme.colors.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      '${stageLeads.length}',
                                      style: theme.typography.labelSmall.copyWith(color: theme.colors.primary),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.all(12),
                                itemCount: stageLeads.length,
                                itemBuilder: (context, leadIndex) {
                                  final lead = stageLeads[leadIndex];
                                  return Card(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    elevation: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text((lead['companyName'] as String?) ?? 'Unknown', style: theme.typography.h5),
                                          const SizedBox(height: 4),
                                          Text((lead['contactName'] as String?) ?? '', style: theme.typography.bodyMedium),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '\$${lead['expectedValue'] ?? 0}',
                                                style: theme.typography.subtitle1.copyWith(color: theme.colors.success),
                                              ),
                                              Icon(Icons.business, size: 16, color: theme.colors.textSecondary),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
