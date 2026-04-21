// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:primecare_ui/src/components/aura/01_I_aura_financial_hud.dart';

class AuraReportToggleNotifier extends Notifier<Map<String, bool>> {
  @override
  Map<String, bool> build() => {};

  void toggle(String reportId) {
    final newState = !(state[reportId] ?? false);
    state = {...state, reportId: newState};

    // Sync the global visualization provider so deeply nested charts update
    ref.read(auraActiveVisualizationProvider.notifier).update(newState);
  }
}

final auraReportToggleProvider =
    NotifierProvider<AuraReportToggleNotifier, Map<String, bool>>(
      AuraReportToggleNotifier.new,
    );

class PrimeCareReportScreen extends ConsumerWidget {
  final String reportId;

  const PrimeCareReportScreen({super.key, required this.reportId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
        .read(executionGateProvider)
        .passGate(
          ExecutionGateCategory.navigationLayer,
          'Navigating to Report: $reportId',
        );
    final reportAsync = ref.watch(reportDataProvider(reportId));
    final layout = ref.watch(layoutProvider);
    final auraToggles = ref.watch(auraReportToggleProvider);
    final isAuraActive = auraToggles[reportId] ?? false;
    final auraForecast = ref.watch(auraFinancialForecastProvider);

    // Responsive scaling factor based on layout density
    final isMobile = layout.tier == ResolutionTier.mob;
    final scale = isMobile ? 0.85 : 1.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: reportAsync.when(
        data: (result) => result.fold(
          (report) => ListView(
            padding: EdgeInsets.all(24 * scale),
            children: [
              // Aura Financial Intelligence HUD (Visible only for revenue reports)
              if (reportId == 'revenue_log' && isAuraActive)
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: AuraFinancialHud(insights: auraForecast.insights),
                ),

              // Header Segment
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        report.title,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 28 * scale,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Last updated: ${DateTime.now().toLocal().toString().split('.')[0]}',
                        style: GoogleFonts.inter(
                          fontSize: 14 * scale,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _ActionButton(
                        icon: LucideIcons.download,
                        label: 'Export',
                        onTap: () {},
                        scale: scale,
                      ),
                      const SizedBox(width: 12),
                      _ActionButton(
                        icon: LucideIcons.share2,
                        label: 'Share',
                        onTap: () {},
                        isPrimary: true,
                        scale: scale,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Metrics Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: isMobile ? 1 : 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 2.5,
                children: [
                  _SummaryCard(
                    label: 'Total Revenue',
                    value: r'$42,850.00',
                    trend: '+12.5%',
                    isPositive: true,
                    scale: scale,
                  ),
                  _SummaryCard(
                    label: 'Pending Claims',
                    value: '143',
                    trend: '-2.4%',
                    isPositive: true,
                    scale: scale,
                  ),
                  _SummaryCard(
                    label: 'Avg. Recovery',
                    value: '88.2%',
                    trend: '+5.1%',
                    isPositive: true,
                    scale: scale,
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Visualization Segment
              if (reportId == 'revenue_log') ...[
                PrimeCareChartCard(
                  title: 'Revenue Velocity - 30 Day View',
                  isAuraSupported: true,
                  isAuraActive: isAuraActive,
                  onAuraToggle: () => ref
                      .read(auraReportToggleProvider.notifier)
                      .toggle(reportId),
                  chart: SizedBox(
                    height: 200,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            LucideIcons.barChart3,
                            size: 48,
                            color: Color(0xFF94A3B8),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            isAuraActive
                                ? 'Displaying AI-Augmented Forecast Logic'
                                : 'Historical Transactional View',
                            style: TextStyle(
                              color: const Color(0xFF64748B),
                              fontSize: 13 * scale,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],

              // Data Segment
              PrimeCareDataTable(
                columns: report.columns.map((col) => col.label).toList(),
                data: report.rows,
                rowBuilder: (row) {
                  return report.columns.map((col) {
                    final value = row.cells[col.key];
                    return DataCell(
                      Text(
                        value?.toString() ?? '-',
                        style: GoogleFonts.inter(
                          fontSize: 14 * scale,
                          color: const Color(0xFF334155),
                          fontWeight: col.isNumeric
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          (error) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  LucideIcons.alertCircle,
                  size: 48,
                  color: Color(0xFFEF4444),
                ),
                const SizedBox(height: 16),
                Text(
                  'Report hydration failed',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  style: GoogleFonts.inter(color: const Color(0xFF64748B)),
                ),
              ],
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                LucideIcons.alertCircle,
                size: 48,
                color: Color(0xFFEF4444),
              ),
              const SizedBox(height: 16),
              Text(
                'Failed to hydrate report data',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                err.toString(),
                style: GoogleFonts.inter(color: const Color(0xFF64748B)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;
  final double scale;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isPrimary = false,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16 * scale,
          vertical: 10 * scale,
        ),
        decoration: BoxDecoration(
          color: isPrimary ? const Color(0xFF2563EB) : PrimeCareColors.white,
          borderRadius: BorderRadius.circular(12),
          border: isPrimary ? null : Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: const Color(0xFF2563EB).withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18 * scale,
              color: isPrimary
                  ? PrimeCareColors.white
                  : const Color(0xFF475569),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14 * scale,
                fontWeight: FontWeight.w600,
                color: isPrimary
                    ? PrimeCareColors.white
                    : const Color(0xFF475569),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final String trend;
  final bool isPositive;
  final double scale;

  const _SummaryCard({
    required this.label,
    required this.value,
    required this.trend,
    required this.isPositive,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: PrimeCareColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13 * scale,
              color: const Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 22 * scale,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E293B),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isPositive
                      ? const Color(0xFFF0FDF4)
                      : const Color(0xFFFEF2F2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  trend,
                  style: GoogleFonts.inter(
                    fontSize: 12 * scale,
                    fontWeight: FontWeight.bold,
                    color: isPositive
                        ? const Color(0xFF166534)
                        : const Color(0xFF991B1B),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
