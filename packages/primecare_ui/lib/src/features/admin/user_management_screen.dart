// Governance - Category: view | Purpose: UI Screen component rendering the User Management Screen workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

final userManagementProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/users');
  return response.data is List 
      ? List<Map<String, dynamic>>.from(response.data as Iterable) 
      : [];
});

class UserManagementScreen extends GovernedConsumerWidget {
  const UserManagementScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final dataState = ref.watch(userManagementProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          'User Management',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: theme.colors.primary),
            onPressed: () {
              // Action to add user
            },
          ),
        ],
      ),
      body: dataState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load users: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (users) => SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Platform Users',
                style: theme.typography.h2.copyWith(color: theme.colors.onBackground),
              ),
              const SizedBox(height: 8),
              Text(
                'Manage all registered users, roles, and access permissions.',
                style: theme.typography.bodyLarge.copyWith(color: theme.colors.textSecondary),
              ),
              const SizedBox(height: 24),
              ResponsiveGrid(
                minItemWidth: 400,
                maxItemWidth: 600,
                spacing: 16.0,
                children: [
                  Card(
                    color: theme.colors.surface,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('User Directory', style: theme.typography.h4),
                          const SizedBox(height: 16),
                          if (users.isEmpty)
                            const Text('No users found.')
                          else
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: users.length,
                              itemBuilder: (context, index) {
                                final user = users[index];
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: theme.colors.primary.withOpacity(0.1),
                                    child: Icon(Icons.person, color: theme.colors.primary),
                                  ),
                                  title: Text(user['name'] as String? ?? 'Unknown User', style: theme.typography.bodyLarge),
                                  subtitle: Text(user['role'] as String? ?? 'No Role Assigned', style: theme.typography.bodyMedium),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {},
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: theme.colors.surface,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Role Distribution', style: theme.typography.h4),
                          const SizedBox(height: 16),
                          // Placeholder for a chart or summary metrics
                          Container(
                            height: 200,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: theme.colors.background,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text('Chart Component Placeholder'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
