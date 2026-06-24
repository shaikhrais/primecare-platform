/* 
PRIME:SCREEN=medical_library_access_portal
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
// Governance - Category: service | Purpose: Core implementation file for the Medical Library Access Portal platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final libraryDatabasesProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/education/library/databases');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class MedicalLibraryAccessPortalScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The Medical Library Access Portal requires components for displaying databases, handling loading and error states, and functionalities for refreshing and searching databases.';

  @override
  List<String> get requiredComponents => const [
        'DatabaseList',
        'LoadingIndicator',
        'ErrorMessage',
        'DatabaseCard',
        'FavoritesList',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchDatabases',
        'refreshDatabaseList',
        'performFederatedSearch',
        'trackUserActivity',
        'saveFavoriteDatabase',
      ];

  const MedicalLibraryAccessPortalScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(libraryDatabasesProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: Text('Medical Library Access Portal', style: theme.typography.h3),
        actions: [
          IconButton(key: const Key('medical_library_access_portal_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(libraryDatabasesProvider),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.search),
              label: const Text('Federated Search'),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err', style: TextStyle(color: theme.colors.error))),
        data: (databases) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('External Databases & Journals', style: theme.typography.h2),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: databases.length,
                  itemBuilder: (context, index) {
                    final db = databases[index];
                    return Card(
                      color: theme.colors.surface,
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.menu_book, size: 48, color: theme.colors.primary),
                              const SizedBox(height: 12),
                              Text(db['name'] as String, style: theme.typography.h4, textAlign: TextAlign.center),
                              const SizedBox(height: 4),
                              Text(db['access_type'] as String, style: theme.typography.labelSmall.copyWith(color: db['access_type'] == 'Open Access' ? Colors.green : Colors.orange)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
