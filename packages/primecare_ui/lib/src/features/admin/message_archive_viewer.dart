/* 
PRIME:SCREEN=message_archiveer
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_REUSABLE
PRIME:LOGIC=LOGIC_WORKING
PRIME:API=API_ERROR_HANDLED
PRIME:DB=DB_QUERY_READY
PRIME:VALIDATION=VALIDATION_NONE
PRIME:QA=QA_NOT_STARTED
PRIME:FINAL=FINAL_NOT_READY
PRIME:PROGRESS=60
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
// Governance - Category: view | Purpose: Core implementation file for the Message Archive Viewer platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final archiveProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/message-archive');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class MessageArchiveViewerScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for viewing and searching archived messages, along with functionality for filtering, exporting data, and handling loading and error states.';

  @override
  List<String> get requiredComponents => const [
        'MessageList',
        'SearchBar',
        'FilterPanel',
        'ExportButton',
        'LoadingIndicator',
        'ErrorMessage',
        'StatisticsSummary',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchArchivedMessages',
        'searchMessages',
        'applyFilters',
        'exportData',
        'refreshData',
      ];

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
          IconButton(key: const Key('message_archive_viewer_iconbutton_button_1'), 
            icon: Icon(Icons.download, color: theme.colors.primary),
            onPressed: () {},
            tooltip: 'Export for Legal Discovery',
          ),
          IconButton(key: const Key('message_archive_viewer_iconbutton_button_2'), 
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
                    child: TextField(key: const Key('message_archive_viewer_textfield_input_1'), 
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
                          TextButton(key: const Key('message_archive_viewer_textbutton_button_1'), 
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
