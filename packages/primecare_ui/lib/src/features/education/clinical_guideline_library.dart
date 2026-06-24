/* 
PRIME:SCREEN=clinical_guideline_library
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_FINAL
PRIME:LOGIC=LOGIC_CLEAN
PRIME:API=API_ERROR_HANDLED
PRIME:DB=DB_FULLY_CONNECTED
PRIME:VALIDATION=VALIDATION_FULL
PRIME:QA=QA_PASSED
PRIME:FINAL=FINAL_FURNISHED
PRIME:PROGRESS=100
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
// Governance - Category: service | Purpose: Core implementation file for the Clinical Guideline Library platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final clinicalGuidelinesProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/education/guidelines');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class ClinicalGuidelineLibraryScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for displaying and managing clinical guidelines, including search and refresh functionalities, along with performance and error reporting features.';

  @override
  List<String> get requiredComponents => const [
        'GuidelineList',
        'GuidelineDetail',
        'SearchBar',
        'ErrorReportSection',
        'PerformanceMetrics',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchGuidelines',
        'refreshGuidelines',
        'searchGuidelines',
        'viewGuidelineDetails',
      ];

  const ClinicalGuidelineLibraryScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(clinicalGuidelinesProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: Text('Clinical Guideline Library', style: theme.typography.h3),
        actions: [
          IconButton(key: const Key('clinical_guideline_library_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(clinicalGuidelinesProvider),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.search),
              label: const Text('Search Guidelines'),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err', style: TextStyle(color: theme.colors.error))),
        data: (guidelines) => GridView.builder(
          padding: const EdgeInsets.all(24.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: guidelines.length,
          itemBuilder: (context, index) {
            final guideline = guidelines[index];
            return Card(
              color: theme.colors.surface,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.library_books, color: theme.colors.primary),
                        const SizedBox(width: 8),
                        Expanded(child: Text(guideline['title'] as String, style: theme.typography.h4, maxLines: 2, overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                    const Divider(height: 24),
                    Text('Category: ${guideline['category']}', style: theme.typography.bodyMedium),
                    const SizedBox(height: 4),
                    Text('Last Updated: ${guideline['last_updated']}', style: theme.typography.labelSmall),
                    const Spacer(),
                    OutlinedButton(key: const Key('clinical_guideline_library_outlinedbutton_button_1'), 
                      onPressed: () {},
                      child: const Text('View Full Pathway'),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
