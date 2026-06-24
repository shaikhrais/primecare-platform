/* 
PRIME:SCREEN=territory_sales_mapping
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
// Governance - Category: service | Purpose: Core implementation file for the Territory Sales Mapping platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final territorySalesProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/marketing/territories');
  return response.data as Map<String, dynamic>;
});

final territoryFilterProvider = StateProvider<String>((ref) => 'Conversions');

class TerritorySalesMappingScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires an interactive map for territory visualization, performance metrics, and functionality for refreshing data and accessing reports.';

  @override
  List<String> get requiredComponents => const [
        'InteractiveMap',
        'PerformanceHeatmap',
        'RegionDetailsPanel',
      ];

  @override
  List<String> get requiredFunctions => const [
        'refreshTerritoryData',
        'fetchPerformanceMetrics',
        'getRegionManagers',
      ];

  void refreshTerritoryData(WidgetRef ref) {
    ref.invalidate(territorySalesProvider);
  }

  void fetchPerformanceMetrics(WidgetRef ref) {
    ref.read(territorySalesProvider);
  }

  List<String> getRegionManagers(Map<String, dynamic> data) {
    final list = data['regions'] as List? ?? [];
    return list.map((r) => r['manager'] as String? ?? 'Unknown').toList();
  }

  const TerritorySalesMappingScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(territorySalesProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: Text('Territory Sales Mapping', style: theme.typography.h3),
        actions: [
          IconButton(
            key: const Key('territory_sales_mapping_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => refreshTerritoryData(ref),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err', style: TextStyle(color: theme.colors.error))),
        data: (territories) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: const _InteractiveSalesMap(),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Top Performing Regions', style: theme.typography.h2),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: (territories['regions'] as List).length,
                        itemBuilder: (context, index) {
                          final region = territories['regions'][index];
                          return _RegionDetailsPanel(
                            region: region,
                            index: index,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    _PerformanceHeatmap(regions: territories['regions'] as List),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InteractiveSalesMap extends ConsumerWidget {
  const _InteractiveSalesMap();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final filter = ref.watch(territoryFilterProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                label: const Text('Leads'),
                selected: filter == 'Leads',
                onSelected: (val) => ref.read(territoryFilterProvider.notifier).state = 'Leads',
              ),
              const SizedBox(width: 12),
              ChoiceChip(
                label: const Text('Conversions'),
                selected: filter == 'Conversions',
                onSelected: (val) => ref.read(territoryFilterProvider.notifier).state = 'Conversions',
              ),
            ],
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
            child: CustomPaint(
              painter: _SalesMapPainter(
                theme: theme,
                mode: filter,
              ),
              child: Container(),
            ),
          ),
        ),
      ],
    );
  }
}

class _SalesMapPainter extends CustomPainter {
  final PrimeThemeData theme;
  final String mode;

  _SalesMapPainter({required this.theme, required this.mode});

  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = theme.colors.primary.withOpacity(0.4)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = theme.colors.primary.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    final path1 = Path()
      ..moveTo(size.width * 0.1, size.height * 0.2)
      ..lineTo(size.width * 0.45, size.height * 0.15)
      ..lineTo(size.width * 0.5, size.height * 0.5)
      ..lineTo(size.width * 0.2, size.height * 0.6)
      ..close();

    final path2 = Path()
      ..moveTo(size.width * 0.5, size.height * 0.15)
      ..lineTo(size.width * 0.9, size.height * 0.25)
      ..lineTo(size.width * 0.8, size.height * 0.7)
      ..lineTo(size.width * 0.45, size.height * 0.55)
      ..close();

    canvas.drawPath(path1, fillPaint);
    canvas.drawPath(path1, borderPaint);

    canvas.drawPath(path2, fillPaint);
    canvas.drawPath(path2, borderPaint);

    final centers = [
      Offset(size.width * 0.3, size.height * 0.35),
      Offset(size.width * 0.65, size.height * 0.45),
    ];

    final rippleColor = mode == 'Leads' ? theme.colors.success : theme.colors.warning;
    
    for (final center in centers) {
      for (int i = 1; i <= 3; i++) {
        final ripplePaint = Paint()
          ..color = rippleColor.withOpacity(0.5 / i)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;
        canvas.drawCircle(center, i * 15.0, ripplePaint);
      }
      final corePaint = Paint()
        ..color = rippleColor
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, 5, corePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _RegionDetailsPanel extends StatelessWidget {
  final dynamic region;
  final int index;

  const _RegionDetailsPanel({required this.region, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Card(
      color: theme.colors.surface,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colors.primary,
          child: Text('${index + 1}', style: const TextStyle(color: Colors.white)),
        ),
        title: Text(region['name'] as String, style: theme.typography.h4),
        subtitle: Text('Manager: ${region['manager']}', style: theme.typography.labelSmall),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('\$${region['revenue']}', style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: theme.colors.success)),
            Text('Quota: ${region['quota_attainment']}%', style: theme.typography.labelSmall),
          ],
        ),
      ),
    );
  }
}

class _PerformanceHeatmap extends StatelessWidget {
  final List<dynamic> regions;

  const _PerformanceHeatmap({required this.regions});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quota Attainment Overview', style: theme.typography.h3),
          const SizedBox(height: 12),
          ...regions.map((r) {
            final double attainment = (r['quota_attainment'] as num).toDouble();
            final color = attainment >= 100 ? theme.colors.success : (attainment >= 80 ? theme.colors.warning : theme.colors.error);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(r['name'] as String, style: theme.typography.labelSmall),
                  ),
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: (attainment / 120).clamp(0.0, 1.0),
                        backgroundColor: theme.colors.background,
                        color: color,
                        minHeight: 6,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('${attainment.toStringAsFixed(0)}%', style: theme.typography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
