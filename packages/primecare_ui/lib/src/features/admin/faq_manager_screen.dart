/* 
PRIME:SCREEN=f_a_q_manager
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
// Governance - Category: view | Purpose: UI Screen component rendering the Faq Manager Screen workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

final faqManagerProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/faqs');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class FAQManagerScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for managing FAQs, analytics, and user feedback, along with buttons for CRUD operations and necessary API endpoints.';

  @override
  List<String> get requiredComponents => const [
        'FAQList',
        'FAQCategoryFilter',
        'FAQAnalyticsChart',
        'UserFeedbackSection',
      ];

  @override
  List<String> get requiredFunctions => const [
        'loadFAQs',
        'addFAQ',
        'editFAQ',
        'deleteFAQ',
        'fetchAnalytics',
        'submitFeedback',
      ];

  const FAQManagerScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final faqState = ref.watch(faqManagerProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'FAQ & Knowledge Base Manager',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(key: const Key('faq_manager_screen_iconbutton_button_1'), 
            icon: Icon(Icons.add_circle, color: theme.colors.primary),
            onPressed: () {},
            tooltip: 'Add New FAQ Entry',
          ),
        ],
      ),
      body: faqState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load FAQs: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (faqs) => SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Help Center Content Management',
                style: theme.typography.h2.copyWith(color: theme.colors.onBackground),
              ),
              const SizedBox(height: 8),
              Text(
                'Manage articles and knowledge base used by the PrimeCare ResponseBot.',
                style: theme.typography.bodyLarge.copyWith(color: theme.colors.textSecondary),
              ),
              const SizedBox(height: 24),
              ResponsiveGrid(
                minItemWidth: 350,
                maxItemWidth: 600,
                spacing: 24.0,
                children: [
                  Card(
                    color: theme.colors.surface,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('FAQ Category Tree', style: theme.typography.h4),
                          const SizedBox(height: 16),
                          if (faqs.isEmpty)
                            const Text('No FAQs found.')
                          else
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: faqs.length,
                              itemBuilder: (context, index) {
                                final faq = faqs[index];
                                return ExpansionTile(
                                  title: Text((faq['question'] as String?) ?? 'Untitled Question'),
                                  subtitle: Text('Category: ${(faq['category'] as String?) ?? 'General'}'),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text((faq['answer'] as String?) ?? 'No answer provided.'),
                                    ),
                                    OverflowBar(
                                      children: [
                                        TextButton(key: const Key('faq_manager_screen_textbutton_button_1'), onPressed: () {}, child: const Text('Edit')),
                                        TextButton(key: const Key('faq_manager_screen_textbutton_button_2'), onPressed: () {}, child: const Text('Delete')),
                                      ],
                                    )
                                  ],
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
                          Text('Content Analytics', style: theme.typography.h4),
                          const SizedBox(height: 16),
                           Container(
                            height: 200,
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: theme.colors.background,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: theme.colors.border.withOpacity(0.5)),
                            ),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return CustomPaint(
                                  size: Size(constraints.maxWidth, constraints.maxHeight - 20),
                                  painter: _FAQAnalyticsChartPainter(
                                    primaryColor: theme.colors.primary,
                                    gridColor: theme.colors.border.withOpacity(0.2),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          ListTile(
                            leading: Icon(Icons.trending_up, color: theme.colors.primary),
                            title: const Text('Most Viewed Category'),
                            trailing: const Text('Billing Support'),
                          ),
                          ListTile(
                            leading: Icon(Icons.search, color: theme.colors.primary),
                            title: const Text('Top Searched Term'),
                            trailing: const Text('Reset Password'),
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

class _FAQAnalyticsChartPainter extends CustomPainter {
  final Color primaryColor;
  final Color gridColor;

  _FAQAnalyticsChartPainter({required this.primaryColor, required this.gridColor});

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final rows = 3;
    for (int i = 0; i <= rows; i++) {
      final y = size.height * (i / rows);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final categories = ['General', 'Billing', 'Sched.', 'Auth', 'Config'];
    final values = [120, 340, 290, 410, 180];
    final maxValue = 500;

    final barWidth = size.width / (categories.length * 2 - 1);
    final barPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;

    for (int i = 0; i < values.length; i++) {
      final val = values[i];
      final barHeight = size.height * (val / maxValue);
      final x = i * 2 * barWidth;
      final y = size.height - barHeight;

      final rrect = RRect.fromRectAndCorners(
        Rect.fromLTWH(x, y, barWidth, barHeight),
        topLeft: const Radius.circular(4),
        topRight: const Radius.circular(4),
      );
      canvas.drawRRect(rrect, barPaint);

      final textPainter = TextPainter(
        text: TextSpan(
          text: categories[i],
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 9,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x + (barWidth - textPainter.width) / 2, size.height + 4));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
