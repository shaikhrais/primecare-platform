import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:primecare_ui/primecare_ui.dart';
import '../../../core/governance/governance_provider.dart';

/// [SubsystemRadarChart] - Visualizes the M/V/C balance of a subsystem.
class SubsystemRadarChart extends StatelessWidget {
  final ProjectHealthSummary summary;

  const SubsystemRadarChart({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final m = summary.mvc['M']?.toDouble() ?? 0;
    final v = summary.mvc['V']?.toDouble() ?? 0;
    final c = summary.mvc['C']?.toDouble() ?? 0;
    
    // Normalize data for radar visualization
    final maxVal = [m, v, c].reduce((a, b) => a > b ? a : b);
    final normalizedM = maxVal > 0 ? m / maxVal : 0.0;
    final normalizedV = maxVal > 0 ? v / maxVal : 0.0;
    final normalizedC = maxVal > 0 ? c / maxVal : 0.0;

    return AspectRatio(
      aspectRatio: 1,
      child: RadarChart(
        RadarChartData(
          radarShape: RadarShape.polygon,
          getTitle: (index, angle) {
            switch (index) {
              case 0: return const RadarChartTitle(text: 'Model');
              case 1: return const RadarChartTitle(text: 'View');
              case 2: return const RadarChartTitle(text: 'Controller');
              default: return const RadarChartTitle(text: '');
            }
          },
          dataSets: [
            RadarDataSet(
              fillColor: Colors.blue.withValues(alpha: 0.3),
              borderColor: Colors.blue,
              entryRadius: 3,
              dataEntries: [
                RadarEntry(value: normalizedM),
                RadarEntry(value: normalizedV),
                RadarEntry(value: normalizedC),
              ],
            ),
          ],
          tickCount: 3,
          ticksTextStyle: const TextStyle(color: Colors.transparent),
          gridBorderData: const BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
    );
  }
}

/// [LocGrowthSparkline] - Simple trend line for LOC density.
class LocGrowthSparkline extends StatelessWidget {
  final List<double> values;
  final Color color;

  const LocGrowthSparkline({
    super.key, 
    required this.values, 
    this.color = Colors.blue
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 100,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: values.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(),
              isCurved: true,
              color: color,
              barWidth: 2,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}

/// [ComponentCoverageHeatmap] - Visualizes implementation status of all 251+ screens.
class ComponentCoverageHeatmap extends StatelessWidget {
  final Map<String, List<bool>> categorizedCoverage;
  final int totalCount;

  const ComponentCoverageHeatmap({
    super.key,
    required this.categorizedCoverage,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Component Implementation Coverage ($totalCount)',
              style: theme.typography.titleSmall.copyWith(fontWeight: FontWeight.bold),
            ),
            _buildLegend(theme),
          ],
        ),
        const SizedBox(height: 16),
        ...categorizedCoverage.entries.map((entry) => _buildCategorySection(context, theme, entry.key, entry.value)),
      ],
    );
  }

  Widget _buildCategorySection(BuildContext context, PrimeThemeData theme, String category, List<bool> coverage) {
    final implementedCount = coverage.where((e) => e).length;
    final progress = coverage.isEmpty ? 0.0 : implementedCount / coverage.length;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(category, style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant, fontWeight: FontWeight.bold)),
              const Spacer(),
              Text(
                '$implementedCount/${coverage.length} (${(progress * 100).toInt()}%)',
                style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant, fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: List.generate(coverage.length, (index) {
              final isImplemented = coverage[index];
              return _HeatmapNode(
                isImplemented: isImplemented,
                delay: (index * 10).ms,
              );
            }),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.05);
  }

  Widget _buildLegend(PrimeThemeData theme) {
    return Row(
      children: [
        _buildLegendItem(Colors.green, 'Live'),
        const SizedBox(width: 12),
        _buildLegendItem(theme.colors.borderLight, 'Pending'),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 9, color: Colors.grey)),
      ],
    );
  }
}

class _HeatmapNode extends StatefulWidget {
  final bool isImplemented;
  final Duration delay;

  const _HeatmapNode({
    required this.isImplemented,
    required this.delay,
  });

  @override
  State<_HeatmapNode> createState() => _HeatmapNodeState();
}

class _HeatmapNodeState extends State<_HeatmapNode> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: _isHovered ? 14 : 10,
        height: _isHovered ? 14 : 10,
        decoration: BoxDecoration(
          color: widget.isImplemented ? Colors.green : Colors.grey.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(2),
          boxShadow: _isHovered && widget.isImplemented
              ? [BoxShadow(color: Colors.green.withValues(alpha: 0.4), blurRadius: 4, spreadRadius: 1)]
              : null,
        ),
      ).animate().scale(delay: widget.delay, duration: 300.ms, curve: Curves.easeOutBack),
    );
  }
}
