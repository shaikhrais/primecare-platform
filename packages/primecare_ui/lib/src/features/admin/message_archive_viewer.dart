// Governance - Category: view | Purpose: Core implementation file for the Message Archive Viewer platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final archiveProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/message-archive');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class MessageArchiveViewerScreen extends GovernedConsumerWidget {
  const MessageArchiveViewerScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final archiveState = ref.watch(archiveProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Immutable Message Archive',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.download, color: theme.colors.primary),
            onPressed: () {},
            tooltip: 'Export for Legal Discovery',
          ),
          IconButton(
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(archiveProvider),
          ),
        ],
      ),
      body: archiveState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load archive: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (archives) => Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: theme.colors.surface,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search by User ID, Date Range, or Keywords...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.filter_list),
                    label: const Text('Filters'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Card(
                  color: theme.colors.surface,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Timestamp')),
                      DataColumn(label: Text('Sender')),
                      DataColumn(label: Text('Recipient')),
                      DataColumn(label: Text('Subject')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: archives.map((doc) => DataRow(
                      cells: [
                        DataCell(Text((doc['timestamp'] as String?) ?? '')),
                        DataCell(Text((doc['sender'] as String?) ?? '')),
                        DataCell(Text((doc['recipient'] as String?) ?? '')),
                        DataCell(Text((doc['subject'] as String?) ?? '')),
                        DataCell(
                          TextButton(
                            onPressed: () {},
                            child: const Text('View Transcript'),
                          ),
                        ),
                      ],
                    )).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
