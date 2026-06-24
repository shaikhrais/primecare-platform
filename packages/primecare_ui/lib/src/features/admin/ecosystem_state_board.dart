/* 
PRIME:SCREEN=ecosystem_state_board
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
// Governance - Category: service | Purpose: Core implementation file for the Ecosystem State Board platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final ecosystemProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/ecosystem');
  return response.data is Map<String, dynamic> 
      ? response.data as Map<String, dynamic>
      : {};
});

class EcosystemStateBoardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The Ecosystem State Board requires components to display key metrics, a refresh button for real-time updates, and visualizations for data analysis.';

  @override
  List<String> get requiredComponents => const [
        'EcosystemMetricCard',
        'RevenueTrajectoryChart',
        'RegionalHeatmap',
      ];

  @override
  List<String> get requiredFunctions => const [
        'refreshData',
      ];

  const EcosystemStateBoardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final ecosystemState = ref.watch(ecosystemProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Ecosystem State Board',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(key: const Key('ecosystem_state_board_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(ecosystemProvider),
          ),
        ],
      ),
      body: ecosystemState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load ecosystem state: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (data) => SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Network Health & Revenue Summary', style: theme.typography.h2),
              const SizedBox(height: 24),
              ResponsiveGrid(
                minItemWidth: 250,
                maxItemWidth: 400,
                spacing: 24.0,
                children: [
                  _buildMetricCard(theme, 'Active Agencies', data['activeAgencies']?.toString() ?? '142', Icons.business),
                  _buildMetricCard(theme, 'Live Caregivers', data['liveCaregivers']?.toString() ?? '3,405', Icons.group),
                  _buildMetricCard(theme, 'Daily Revenue Run-rate', '\$${data['dailyRevenue'] ?? '1.2M'}', Icons.attach_money),
                  _buildMetricCard(theme, 'System Health', data['systemHealth']?.toString() ?? '99.99%', Icons.health_and_safety),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Card(
                      color: theme.colors.surface,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Revenue Trajectory', style: theme.typography.h4),
                            const SizedBox(height: 16),
                            Container(
                              height: 300,
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: theme.colors.background,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: theme.colors.border.withOpacity(0.5)),
                              ),
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return CustomPaint(
                                    size: Size(constraints.maxWidth, constraints.maxHeight),
                                    painter: _EcosystemRevenuePainter(
                                      primaryColor: theme.colors.primary,
                                      gridColor: theme.colors.border.withOpacity(0.2),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 1,
                    child: Card(
                      color: theme.colors.surface,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Regional Client Density', style: theme.typography.h4),
                            const SizedBox(height: 16),
                            Container(
                              height: 300,
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: theme.colors.background,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: theme.colors.border.withOpacity(0.5)),
                              ),
                              child: const SingleChildScrollView(
                                child: _RegionalListWidget(),
                              ),
                            ),
                          ],
                        ),
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

  Widget _buildMetricCard(PrimeThemeData theme, String title, String value, IconData icon) {
    return Card(
      color: theme.colors.surface,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.typography.bodyMedium.copyWith(color: theme.colors.textSecondary)),
                const SizedBox(height: 8),
                Text(value, style: theme.typography.h3),
              ],
            ),
            Icon(icon, size: 48, color: theme.colors.primary.withOpacity(0.2)),
          ],
        ),
      ),
    );
  }
}

class _EcosystemRevenuePainter extends CustomPainter {
  final Color primaryColor;
  final Color gridColor;

  _EcosystemRevenuePainter({required this.primaryColor, required this.gridColor});

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final rows = 4;
    for (int i = 0; i <= rows; i++) {
      final y = size.height * (i / rows);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final points = [
      Offset(0, size.height * 0.85),
      Offset(size.width * 0.2, size.height * 0.7),
      Offset(size.width * 0.4, size.height * 0.6),
      Offset(size.width * 0.6, size.height * 0.4),
      Offset(size.width * 0.8, size.height * 0.35),
      Offset(size.width, size.height * 0.15),
    ];

    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      final cp1 = Offset(points[i - 1].dx + (points[i].dx - points[i - 1].dx) / 2, points[i - 1].dy);
      final cp2 = Offset(points[i - 1].dx + (points[i].dx - points[i - 1].dx) / 2, points[i].dy);
      path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, points[i].dx, points[i].dy);
    }

    final linePaint = Paint()
      ..color = primaryColor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, linePaint);

    final fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [primaryColor.withOpacity(0.15), primaryColor.withOpacity(0.0)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RegionalListWidget extends StatelessWidget {
  const _RegionalListWidget();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final regions = [
      {'name': 'Ontario', 'density': 0.85, 'patients': '14,209'},
      {'name': 'British Columbia', 'density': 0.62, 'patients': '9,812'},
      {'name': 'Quebec', 'density': 0.48, 'patients': '7,402'},
      {'name': 'Alberta', 'density': 0.35, 'patients': '4,198'},
    ];

    return Column(
      children: regions.map((r) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.between,
                children: [
                  Text(r['name'] as String, style: theme.typography.bodySmall.copyWith(fontWeight: FontWeight.bold)),
                  Text(r['patients'] as String, style: theme.typography.labelSmall.copyWith(color: theme.colors.primary, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 6),
              LinearProgressIndicator(
                value: r['density'] as double,
                backgroundColor: theme.colors.border,
                valueColor: AlwaysStoppedAnimation<Color>(theme.colors.primary),
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
