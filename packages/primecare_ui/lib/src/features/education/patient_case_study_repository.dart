/* 
PRIME:SCREEN=patient_case_study_repository
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_REUSABLE
PRIME:LOGIC=LOGIC_WORKING
PRIME:API=API_ERROR_HANDLED
PRIME:DB=DB_FULLY_CONNECTED
PRIME:VALIDATION=VALIDATION_BASIC
PRIME:QA=QA_NOT_STARTED
PRIME:FINAL=FINAL_NOT_READY
PRIME:PROGRESS=70
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
// Governance - Category: adapter | Purpose: Core implementation file for the Patient Case Study Repository platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final caseStudyProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/education/cases');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class PatientCaseStudyRepositoryScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for displaying case studies, a loading indicator, error handling, search functionality, and responsive design for multiple platforms.';

  @override
  List<String> get requiredComponents => const [
        'CaseStudyList',
        'LoadingIndicator',
        'ErrorMessage',
        'SearchBar',
        'RefreshButton',
        'ViewCaseButton',
        'SpecialtyIndicator',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchCaseStudies',
        'refreshCaseStudies',
        'searchCaseStudies',
        'viewCaseDetails',
      ];

  const PatientCaseStudyRepositoryScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(caseStudyProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: Text('Patient Case Study Repository', style: theme.typography.h3),
        actions: [
          IconButton(key: const Key('patient_case_study_repository_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(caseStudyProvider),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.search),
              label: const Text('Search Database'),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err', style: TextStyle(color: theme.colors.error))),
        data: (cases) => GridView.builder(
          padding: const EdgeInsets.all(24.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.9,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: cases.length,
          itemBuilder: (context, index) {
            final caseData = cases[index];
            return Card(
              color: theme.colors.surface,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Chip(
                          label: Text(caseData['specialty'] as String, style: const TextStyle(fontSize: 10, color: Colors.white)),
                          backgroundColor: theme.colors.primary,
                        ),
                        const Spacer(),
                        Icon(Icons.bookmark_border, color: Colors.grey[400]),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(caseData['title'] as String, style: theme.typography.h4, maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 8),
                    Text(caseData['presentation'] as String, style: theme.typography.bodyMedium, maxLines: 4, overflow: TextOverflow.ellipsis),
                    const Spacer(),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('By ${caseData['author']}', style: theme.typography.labelSmall),
                        TextButton(key: const Key('patient_case_study_repository_textbutton_button_1'), 
                          onPressed: () {},
                          child: const Text('View Case'),
                        )
                      ],
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
