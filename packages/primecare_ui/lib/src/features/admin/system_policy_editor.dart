// Governance - Category: service | Purpose: Core implementation file for the System Policy Editor platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final systemPoliciesProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/policies');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class SystemPolicyEditor extends GovernedConsumerWidget {
  const SystemPolicyEditor({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final policyState = ref.watch(systemPoliciesProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'System Policy Editor',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: theme.colors.primary),
            onPressed: () {},
            tooltip: 'Create New Policy',
          ),
          IconButton(
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(systemPoliciesProvider),
          ),
        ],
      ),
      body: policyState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load policies: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (policies) => Row(
          children: [
            // Sidebar for Policy List
            Container(
              width: 300,
              decoration: BoxDecoration(
                color: theme.colors.surface,
                border: Border(right: BorderSide(color: theme.colors.border)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Active Policies', style: theme.typography.h4),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: policies.length,
                      itemBuilder: (context, index) {
                        final policy = policies[index];
                        return ListTile(
                          title: Text(policy['name'] as String? ?? 'Untitled'),
                          subtitle: Text('v${policy['version'] ?? 1.0}'),
                          selected: index == 0,
                          onTap: () {},
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Main Editor Area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Policy Document', style: theme.typography.h2),
                        Row(
                          children: [
                            Text('Enforce Platform-Wide', style: theme.typography.bodyLarge),
                            Switch(value: true, onChanged: (val) {}),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('Save Changes'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.colors.surface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: theme.colors.border),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: TextField(
                                  maxLines: null,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter Markdown content...',
                                  ),
                                  controller: TextEditingController(text: '# Sample Policy\n\nThis is a sample markdown policy document. Changes made here are propagated across the platform.'),
                                ),
                              ),
                            ),
                            Container(
                              width: 1,
                              color: theme.colors.border,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Markdown Preview Rendered Here...',
                                  style: theme.typography.bodyLarge.copyWith(color: theme.colors.textSecondary),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
