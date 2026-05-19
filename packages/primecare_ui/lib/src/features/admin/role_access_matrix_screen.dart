import 'package:primecare_ui/primecare_ui.dart';

final roleAccessProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/roles/matrix');
  return response.data is Map<String, dynamic> 
      ? response.data as Map<String, dynamic>
      : {};
});

class RoleAccessMatrixScreen extends GovernedConsumerWidget {
  const RoleAccessMatrixScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final accessState = ref.watch(roleAccessProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Role Access Matrix',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.save),
            label: const Text('Save Permissions'),
            onPressed: () {},
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: accessState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load matrix: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (matrixData) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Granular Permission Configuration', style: theme.typography.h2),
              const SizedBox(height: 8),
              Text(
                'Define exactly which CRUD operations each role can perform across the system.',
                style: theme.typography.bodyLarge.copyWith(color: theme.colors.textSecondary),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Card(
                  color: theme.colors.surface,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      child: DataTable(
                        headingTextStyle: theme.typography.h5,
                        columns: const [
                          DataColumn(label: Text('Resource')),
                          DataColumn(label: Text('Admin')),
                          DataColumn(label: Text('Clinical Dir')),
                          DataColumn(label: Text('Care Coord')),
                          DataColumn(label: Text('Field Staff')),
                        ],
                        rows: List.generate(
                          10,
                          (index) => DataRow(
                            cells: [
                              DataCell(Text('Resource Domain ${index + 1}')),
                              DataCell(Checkbox(value: true, onChanged: (v) {})),
                              DataCell(Checkbox(value: index % 2 == 0, onChanged: (v) {})),
                              DataCell(Checkbox(value: index % 3 == 0, onChanged: (v) {})),
                              DataCell(Checkbox(value: false, onChanged: (v) {})),
                            ],
                          ),
                        ),
                      ),
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
