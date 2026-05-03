// Layer: 02_COMPONENTS
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/theme/aura/aura_role_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'aura_models.dart';
import 'dart:ui';
import 'package:fl_chart/fl_chart.dart';
export '../components/governed_widget.dart';

enum PrimeCareButtonType { primary, secondary, danger, ghost }

/// Standard PrimeCare Card with institutional aesthetics.
class PrimeCareCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final Color? color;

  const PrimeCareCard({
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? EdgeInsets.all(theme.spacing.md),
      decoration: BoxDecoration(
        color: color ?? theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radii.lg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Standardized Button for the PrimeCare platform.
class PrimeCareButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final bool isSecondary;
  final IconData? icon;

  PrimeCareButton({
    required this.onPressed,
    String? label,
    String? text,
    bool isSecondary = false,
    bool? isPrimary,
    dynamic type,
    this.icon,
    super.key,
  }) : label = label ?? text ?? '',
       isSecondary = type != null
           ? type.toString().contains('secondary')
           : (isPrimary != null ? !isPrimary : isSecondary);

  const PrimeCareButton.secondary({
    required this.onPressed,
    required this.label,
    this.icon,
    super.key,
  }) : isSecondary = true;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final primaryColor = isSecondary
        ? theme.colors.secondary
        : theme.colors.primary;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: isSecondary ? theme.colors.onSurface : Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.md,
          vertical: theme.spacing.sm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(theme.radii.md),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18),
            SizedBox(width: theme.spacing.xs),
          ],
          Text(
            label,
            style: theme.typography.labelLarge.copyWith(
              color: isSecondary ? theme.colors.onSurface : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

/// A loading widget tailored for PrimeCare dashboards.
class DashboardLoadingWidget extends StatelessWidget {
  const DashboardLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

/// An error widget with retry capability for dashboards.
class DashboardErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const DashboardErrorWidget({required this.message, this.onRetry, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: theme.colors.error, size: 48),
          SizedBox(height: theme.spacing.md),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.typography.bodyMedium,
          ),
          if (onRetry != null) ...[
            SizedBox(height: theme.spacing.md),
            PrimeCareButton(onPressed: onRetry, label: 'Retry'),
          ],
        ],
      ),
    );
  }
}

/// High-fidelity Chart Card.
class PrimeCareChartCard extends StatelessWidget {
  final String title;
  final Widget chart;

  const PrimeCareChartCard({
    required this.title,
    required this.chart,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.typography.titleMedium),
          SizedBox(height: theme.spacing.md),
          Expanded(child: chart),
        ],
      ),
    );
  }
}

/// High-fidelity implementation of Line Chart using fl_chart
class PrimeCareLineChart extends StatelessWidget {
  final AnalyticsChart chart;
  final Color? lineColor;

  const PrimeCareLineChart({required this.chart, this.lineColor, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    
    // Fallback if no data
    if (chart.datasets.isEmpty && chart.dataPoints.isEmpty) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          color: theme.colors.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(theme.radii.md),
        ),
        child: Center(
          child: Text(
            'No Data Available',
            style: theme.typography.labelMedium.copyWith(color: theme.colors.onSurfaceVariant),
          ),
        ),
      );
    }

    // Determine values to plot. Favor datasets if available, otherwise dataPoints.
    List<LineChartBarData> barDataList = [];
    final primaryColor = lineColor ?? theme.colors.primary;

    if (chart.datasets.isNotEmpty) {
      for (int i = 0; i < chart.datasets.length; i++) {
        final dataset = chart.datasets[i];
        final color = dataset.color != null 
            ? _parseColor(dataset.color!) 
            : (i == 0 ? primaryColor : theme.colors.secondary);
            
        barDataList.add(
          LineChartBarData(
            spots: dataset.data.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(),
            isCurved: true,
            color: color,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: color.withValues(alpha: 0.1),
            ),
          ),
        );
      }
    } else {
      barDataList.add(
        LineChartBarData(
          spots: chart.dataPoints.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.value)).toList(),
          isCurved: true,
          color: primaryColor,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: primaryColor.withValues(alpha: 0.1),
          ),
        ),
      );
    }

    return Container(
      height: 240,
      padding: EdgeInsets.only(top: theme.spacing.md, right: theme.spacing.md),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 1,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: theme.colors.outlineVariant.withValues(alpha: 0.5),
                strokeWidth: 1,
                dashArray: [5, 5],
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  String label = '';
                  if (chart.labels.isNotEmpty && index >= 0 && index < chart.labels.length) {
                    label = chart.labels[index];
                  } else if (chart.dataPoints.isNotEmpty && index >= 0 && index < chart.dataPoints.length) {
                    label = chart.dataPoints[index].label;
                  }
                  return SideTitleWidget(
                    meta: meta,
                    child: Text(
                      label,
                      style: theme.typography.labelSmall.copyWith(color: theme.colors.onSurfaceVariant),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                reservedSize: 42,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toStringAsFixed(0),
                    style: theme.typography.labelSmall.copyWith(color: theme.colors.onSurfaceVariant),
                    textAlign: TextAlign.left,
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: barDataList,
        ),
      ),
    );
  }
  
  Color _parseColor(String colorString) {
    try {
      if (colorString.startsWith('#')) {
        return Color(int.parse(colorString.substring(1, 7), radix: 16) + 0xFF000000);
      }
      return Colors.blue; // Fallback
    } catch (_) {
      return Colors.blue;
    }
  }
}

/// Responsive Grid for KPI cards.
class PrimeCareResponsiveKpiGrid extends StatelessWidget {
  final List<Widget>? children;
  final DashboardMetrics? metrics;

  const PrimeCareResponsiveKpiGrid({this.children, this.metrics, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Wrap(
      spacing: theme.spacing.md,
      runSpacing: theme.spacing.md,
      children: children ?? [],
    );
  }
}

/// Offline Status Indicator.
class OfflineStatusChip extends StatelessWidget {
  const OfflineStatusChip({super.key});

  @override
  Widget build(BuildContext context) {
    return const Chip(
      label: Text('OFFLINE MODE'),
      backgroundColor: Colors.orange,
      labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}

/// Aura Intelligence Insight Card.
class IntelligenceInsightCard extends StatelessWidget {
  final IntelligenceInsight insight;
  const IntelligenceInsightCard({required this.insight, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return PrimeCareCard(
      color: theme.colors.primary.withValues(alpha: 0.05),
      child: Row(
        children: [
          Icon(Icons.auto_awesome, color: theme.colors.primary),
          SizedBox(width: theme.spacing.md),
          Expanded(
            child: Text(insight.summary.en, style: theme.typography.bodyMedium),
          ),
        ],
      ),
    );
  }
}

enum AppShellType { desktop, mobile, tablet, minimal, admin, client, provider }

/// Master Layout wrapper for consistency.
class MasterLayout extends ConsumerWidget {
  final Widget child;
  final Widget? drawer;
  final AppShellType? shellType;
  const MasterLayout({
    required this.child,
    this.drawer,
    this.shellType,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portalConfig = ref.watch(portalConfigProvider);
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.colors.background,
      drawer: drawer,
      appBar: AppBar(
        title: Text(
          portalConfig.title,
          style: theme.typography.titleLarge.copyWith(
            color: theme.colors.onSurface,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: theme.colors.background.withValues(alpha: 0.8),
            ),
          ),
        ),
      ),
      body: AuraVisionRenderer(
        liveWidget: child,
      ),
    );
  }
}

/// High-fidelity Stat Card for dashboards.
class PrimeStatCard extends StatelessWidget {
  final String title;
  final String value;
  final double? delta;
  final String? deltaSuffix;
  final IconData icon;
  final Color iconColor;

  const PrimeStatCard({
    required this.title,
    required this.value,
    this.delta,
    this.deltaSuffix,
    required this.icon,
    required this.iconColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return PrimeCareCard(
      width: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              SizedBox(width: theme.spacing.xs),
              Expanded(
                child: Text(
                  title,
                  style: theme.typography.labelMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: theme.spacing.sm),
          Text(value, style: theme.typography.h3),
          if (delta != null) ...[
            SizedBox(height: theme.spacing.xs),
            Text(
              '${delta! > 0 ? "+" : ""}${delta!.toStringAsFixed(1)}% $deltaSuffix',
              style: theme.typography.labelSmall.copyWith(
                color: delta! > 0 ? theme.colors.success : theme.colors.error,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Skeleton loader for content blocks.
class PrimeCareSkeleton extends StatelessWidget {
  final double? width;
  final double? height;
  final double? radius;

  const PrimeCareSkeleton({this.width, this.height, this.radius, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: theme.colors.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(radius ?? theme.radii.sm),
      ),
    );
  }
}

/// A high-fidelity KPI Card for dashboards.
class PrimeCareKpiCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData? icon;
  final bool isPinned;
  final VoidCallback? onPinToggle;
  final Color? color;

  const PrimeCareKpiCard({
    required this.title,
    required this.value,
    this.subtitle = '',
    this.icon,
    this.isPinned = false,
    this.onPinToggle,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return PrimeCareCard(
      width: 240,
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: 16, color: theme.colors.primary),
                      SizedBox(width: theme.spacing.xs),
                    ],
                    Expanded(
                      child: Text(
                        title,
                        style: theme.typography.labelMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              if (onPinToggle != null)
                IconButton(
                  icon: Icon(
                    isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                    size: 16,
                    color: isPinned
                        ? theme.colors.primary
                        : theme.colors.onSurfaceVariant,
                  ),
                  onPressed: onPinToggle,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
            ],
          ),
          SizedBox(height: theme.spacing.sm),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(value, style: theme.typography.h3),
          ),
          if (subtitle.isNotEmpty) ...[
            SizedBox(height: theme.spacing.xs),
            Text(
              subtitle,
              style: theme.typography.labelSmall.copyWith(
                color: theme.colors.slateGray,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}

/// A high-fidelity Aura-styled Card for intelligence metrics.
class PrimeCareAuraCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData? icon;
  final Color? color;

  const PrimeCareAuraCard({
    required this.title,
    required this.value,
    this.subtitle = '',
    this.icon,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return PrimeCareCard(
      width: 240,
      color: color ?? theme.colors.primary.withValues(alpha: 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: theme.colors.primary),
                SizedBox(width: theme.spacing.xs),
              ],
              Expanded(
                child: Text(
                  title,
                  style: theme.typography.labelMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: theme.spacing.sm),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(value, style: theme.typography.h3),
          ),
          if (subtitle.isNotEmpty) ...[
            SizedBox(height: theme.spacing.xs),
            Text(
              subtitle,
              style: theme.typography.labelSmall.copyWith(
                color: theme.colors.slateGray,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}

/// Aura real-time intelligence HUD.
/// Aligned with "Clinical Atelier" high-fidelity standards.
class AuraDashboardHud extends ConsumerWidget {
  final String? title;
  final String? value;
  final String? auraLabel;

  const AuraDashboardHud({
    this.title,
    this.value,
    this.auraLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final auraTheme = AuraRoleTheme.resolve(ref);
    final visionMode = ref.watch(auraVisionProvider);
    final pulseEvent = ref.watch<AuraEvent?>(auraPulseEventProvider);

    // Only allow live telemetry to override if we are in live mode.
    final hasActiveEvent = visionMode == AuraVisionMode.live && 
                          pulseEvent != null && 
                          pulseEvent.type != AuraEventType.stableheartbeat;

    final displayTitle = hasActiveEvent ? pulseEvent.title.toUpperCase() : (title ?? 'SYSTEM INTELLIGENCE ACTIVE');
    final displayValue = hasActiveEvent ? _getEventValue(pulseEvent) : (value ?? 'OPTIMIZED');
    final displayLabel = hasActiveEvent ? 'AURA PULSE: ${pulseEvent.impact.name.toUpperCase()}' : (auraLabel ?? auraTheme.auraLabel);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(theme.radii.xxl),
        boxShadow: [
          BoxShadow(
            color: auraTheme.primaryGradient.first.withValues(alpha: 0.2),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(theme.radii.xxl),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: EdgeInsets.all(theme.spacing.xl),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  auraTheme.primaryGradient.first.withValues(alpha: 0.8),
                  auraTheme.primaryGradient.last.withValues(alpha: 0.9),
                ],
              ),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
                width: 0.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      displayLabel,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: hasActiveEvent ? Colors.white : Colors.white.withValues(alpha: 0.7),
                        letterSpacing: 2.5,
                      ),
                    ),
                    _AuraPulseIndicator(
                      color: hasActiveEvent ? _getImpactColor(pulseEvent.impact) : auraTheme.pulseColor,
                      isAlert: hasActiveEvent && pulseEvent.impact == InsightImpact.alert,
                    ),
                  ],
                ),
                SizedBox(height: theme.spacing.md),
                Text(
                  displayTitle,
                  style: GoogleFonts.manrope(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                SizedBox(height: theme.spacing.xs),
                Text(
                  displayValue,
                  style: GoogleFonts.manrope(
                    fontSize: 42,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -1.5,
                  ),
                ),
                if (hasActiveEvent) ...[
                  SizedBox(height: theme.spacing.sm),
                  Text(
                    pulseEvent.description,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getEventValue(AuraEvent event) {
    if (event.metadata != null && event.metadata!.containsKey('telemetryValue')) {
      return event.metadata!['telemetryValue'] as String;
    }
    return event.type.name.split('.').last.replaceAll(RegExp(r'(?=[A-Z])'), ' ').toUpperCase();
  }

  Color _getImpactColor(InsightImpact impact) {
    switch (impact) {
      case InsightImpact.alert: return Colors.redAccent;
      case InsightImpact.caution: return Colors.orangeAccent;
      case InsightImpact.positive: return Colors.greenAccent;
      default: return Colors.blueAccent;
    }
  }
}

class _AuraPulseIndicator extends StatefulWidget {
  final Color color;
  final bool isAlert;
  const _AuraPulseIndicator({required this.color, this.isAlert = false});

  @override
  State<_AuraPulseIndicator> createState() => _AuraPulseIndicatorState();
}

class _AuraPulseIndicatorState extends State<_AuraPulseIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color,
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: (widget.isAlert ? 0.8 : 0.6) * _controller.value),
                blurRadius: (widget.isAlert ? 20 : 10) * _controller.value,
                spreadRadius: (widget.isAlert ? 8 : 4) * _controller.value,
              ),
            ],
          ),
        );
      },
    );
  }
}

/// A standardized action item for quick navigation.
class PrimeCareActionItem {
  final String title;
  final IconData icon;
  final String route;
  const PrimeCareActionItem({
    required this.title,
    required this.icon,
    required this.route,
  });
}

/// A grid for displaying quick action items.
class PrimeCareQuickActionsGrid extends StatelessWidget {
  final List<PrimeCareActionItem> actions;
  const PrimeCareQuickActionsGrid({required this.actions, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 2.5,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final action = actions[index];
        return PrimeCareCard(
          padding: EdgeInsets.all(theme.spacing.sm),
          child: InkWell(
            onTap: () {},
            child: Row(
              children: [
                Icon(action.icon, color: theme.colors.primary, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    action.title,
                    style: theme.typography.labelSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Base layout shell for consistent screen wrapping.
class BaseLayoutShell extends ConsumerWidget {
  final Widget child;
  final String currentPath;

  const BaseLayoutShell({
    required this.child,
    required this.currentPath,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layoutConfig = ref.watch(layoutProvider);
    final scale = layoutConfig.scaleFactor;

    return Scaffold(
      appBar: AppBar(toolbarHeight: 56.0 * scale),
      body: Padding(
        key: const Key('shell_content_padding'),
        padding: EdgeInsets.only(left: 24.0 * scale, top: 16.0 * scale),
        child: child,
      ),
    );
  }
}

/// Automatically dims or disables components based on subsystem health.
class WidgetModulationGovernor extends StatelessWidget {
  final PlatformSubsystem subsystem;
  final Widget child;

  const WidgetModulationGovernor({
    required this.subsystem,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return child; // Stub for modulation
  }
}

/// Renderer for Stitch-orchestrated screens.
/// Integrated with Aura Vision for high-fidelity HDL previews.
class StitchEngineRenderer extends ConsumerWidget {
  final String featureId;
  final List<dynamic> items;
  final String? visualCategory;

  const StitchEngineRenderer({
    required this.featureId,
    required this.items,
    this.visualCategory,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Wrap in AuraVisionRenderer to support HDL/Blueprint modes automatically
    return AuraVisionRenderer(
      blueprint: AuraScreenBlueprint(
        screenId: featureId,
        title: featureId.replaceAll('_', ' ').toUpperCase(),
        visualCategory: visualCategory ?? 'General',
        mockData: _resolveMockData(featureId),
        components: items.map((e) => e.toString()).toList(),
      ),
      liveWidget: _buildComponentStack(context),
    );
  }

  Widget _buildComponentStack(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Text('Empty Stitch Canvas: $featureId', 
        style: const TextStyle(color: Colors.grey)),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: items.map((itemId) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ComponentWarehouse.build(context, itemId.toString(), featureId),
          );
        }).toList(),
      ),
    );
  }

  Map<String, dynamic> _resolveMockData(String id) {
    // Centralized mock data resolution logic
    if (id.contains('FINANCE')) return {'telemetryValue': r'$2.4M', 'status': 'Stable'};
    if (id.contains('CLINICAL')) return {'telemetryValue': '98%', 'status': 'Excellent'};
    return {'telemetryValue': '--', 'status': 'Pending'};
  }
}

class ComponentWarehouse {
  static final Map<String, Widget Function(BuildContext, dynamic)> _registry = {};

  static void register(
    String id,
    Widget Function(BuildContext, dynamic) builder,
  ) {
    _registry[id] = builder;
  }

  static Widget Function(BuildContext, dynamic)? getBuilder(String id) {
    return _registry[id];
  }

  static Widget build(BuildContext context, String componentId, String featureId) {
    // Check registry first
    final builder = getBuilder(componentId);
    if (builder != null) return builder(context, null);

    switch (componentId) {
      case 'AuraDashboardHud':
      case 'DASHBOARD_HUD':
        return AuraDashboardHud(
          title: 'INTELLIGENCE UNIT',
          value: '--',
          auraLabel: featureId,
        );
      case 'MetricCard':
        return const Placeholder(fallbackHeight: 100);
      case 'RevenueProjectionModel':
        return const RevenueProjectionModel();
      case 'LiveDispatchMap':
        return const LiveDispatchMap();
      case 'RoboticDispensingInterface':
        return const RoboticDispensingInterface();
      case 'AuditLogPanel':
        return const AuraComponentStub(title: 'AUDIT LOG PANEL', icon: Icons.history_edu, color: Colors.purple);
      case 'UserAccessGrid':
        return const AuraComponentStub(title: 'USER ACCESS GRID', icon: Icons.people, color: Colors.blue);
      case 'GitStatusStream':
        return const AuraComponentStub(title: 'GIT STATUS STREAM', icon: Icons.terminal, color: Colors.cyan);
      case 'CodeAnalysisGauge':
        return const AuraComponentStub(title: 'CODE ANALYSIS GAUGE', icon: Icons.analytics, color: Colors.indigo);
      case 'ComplianceChecklist':
        return const AuraComponentStub(title: 'COMPLIANCE CHECKLIST', icon: Icons.rule, color: Colors.deepPurple);
      case 'AuditHistory':
        return const AuraComponentStub(title: 'AUDIT HISTORY', icon: Icons.assignment, color: Color(0xFF8B5CF6));
      case 'PersonalCalendar':
        return const AuraComponentStub(title: 'PERSONAL CALENDAR', icon: Icons.calendar_month, color: Colors.pink);
      case 'TaskQueue':
        return const AuraComponentStub(title: 'TASK QUEUE', icon: Icons.list_alt, color: Colors.orange);
      case 'GlobalReachMap':
        return const AuraComponentStub(title: 'GLOBAL REACH MAP', icon: Icons.public, color: Colors.red);
      case 'ExecutiveSummary':
        return const AuraComponentStub(title: 'EXECUTIVE SUMMARY', icon: Icons.summarize, color: Colors.redAccent);
      default:
        return Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          ),
          child: Center(child: Text('Component Stub: $componentId')),
        );
    }
  }
}

/// Standardized Insight Row for dashboards.
class DashboardInsightRow extends StatelessWidget {
  final String title;
  final String description;
  final String type;

  const DashboardInsightRow({
    required this.title,
    required this.description,
    required this.type,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IntelligenceInsightCard(
      insight: IntelligenceInsight(
        id: 'legacy_row',
        title: PrimeCareLabel(title),
        summary: PrimeCareLabel(description),
        impact: InsightImpact.info,
        type: InsightType.values.firstWhere(
          (e) => e.name == type,
          orElse: () => InsightType.info,
        ),
      ),
    );
  }
}

/// Standardized Icon for the PrimeCare platform.
class PrimeCareIcon extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color? color;

  const PrimeCareIcon(this.icon, {this.size, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: size, color: color);
  }
}

/// Standardized DataTable for the PrimeCare platform.
class PrimeCareDataTable<T> extends StatelessWidget {
  final List<String> columns;
  final List<DataRow> rows;

  const PrimeCareDataTable({
    required this.columns,
    required this.rows,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(theme.colors.surface),
        columns: columns
            .map(
              (c) => DataColumn(
                label: Text(c, style: theme.typography.labelSmall),
              ),
            )
            .toList(),
        rows: rows,
      ),
    );
  }
}

/// Standardized Badge types for the PrimeCare platform.
enum BadgeType { success, warning, error, info, neutral }

/// Standardized Chip for the PrimeCare platform.
class PrimeCareChip extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final Color? color;

  const PrimeCareChip({
    required this.label,
    VoidCallback? onPressed,
    VoidCallback? onTap,
    this.color,
    super.key,
  }) : onTap = onPressed ?? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: (color ?? theme.colors.primary).withAlpha(15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: theme.typography.labelSmall.copyWith(
            color: color ?? theme.colors.primary,
          ),
        ),
      ),
    );
  }
}

/// Standardized TextField for PrimeCare forms.
class PrimeCareTextField extends StatelessWidget {
  final String label;
  final String? placeholder;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final int? maxLines;
  final bool obscureText;

  final String? Function(String?)? validator; // Function-based validation
  final String? hintText; // Alias for placeholder

  const PrimeCareTextField({
    required this.label,
    this.placeholder,
    this.hintText,
    this.controller,
    this.onChanged,
    this.validator,
    this.maxLines = 1,
    this.obscureText = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.typography.labelSmall),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          maxLines: maxLines,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText ?? placeholder,
            filled: true,
            fillColor: theme.colors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(theme.radii.md),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(theme.radii.md),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: theme.spacing.md,
              vertical: theme.spacing.md,
            ),
          ),
        ),
      ],
    );
  }
}

/// Standardized Dropdown for PrimeCare forms.
class PrimeCareDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;

  const PrimeCareDropdown({
    required this.label,
    required this.value,
    required this.items,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.typography.labelSmall),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          initialValue: value,
          items: items,
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: theme.colors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(theme.radii.md),
              borderSide: BorderSide(color: theme.colors.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(theme.radii.md),
              borderSide: BorderSide(color: theme.colors.borderLight),
            ),
            contentPadding: EdgeInsets.all(theme.spacing.md),
          ),
        ),
      ],
    );
  }
}

/// A high-fidelity page template for dashboard screens.
class PageTemplate extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final Widget body;

  const PageTemplate({
    required this.title,
    this.subtitle,
    this.actions,
    required this.body,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return MasterLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.typography.h3),
              if (subtitle != null)
                Text(subtitle!, style: theme.typography.labelSmall),
            ],
          ),
          actions: actions,
        ),
        body: body,
      ),
    );
  }
}

/// Standardized Badge for the PrimeCare platform.
class PrimeCareBadge extends StatelessWidget {
  final String text;
  final BadgeType? type;
  final Color? color;

  const PrimeCareBadge({required this.text, this.type, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final badgeColor = color ?? _getColor(theme);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: badgeColor.withValues(alpha: 0.2)),
      ),
      child: Text(
        text,
        style: theme.typography.labelSmall.copyWith(color: badgeColor),
      ),
    );
  }

  Color _getColor(PrimeCareThemeData theme) {
    switch (type) {
      case BadgeType.success:
        return theme.colors.success;
      case BadgeType.warning:
        return theme.colors.warning;
      case BadgeType.error:
        return theme.colors.error;
      case BadgeType.info:
        return theme.colors.primary;
      case BadgeType.neutral:
        return theme.colors.onSurfaceVariant;
      default:
        return theme.colors.primary;
    }
  }
}

/// Standardized Tab for the PrimeCare platform.
class PrimeCareTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const PrimeCareTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.lg,
          vertical: theme.spacing.md,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? theme.colors.primary : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: theme.typography.labelLarge.copyWith(
            color: isSelected
                ? theme.colors.primary
                : theme.colors.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

/// Specialized Aura Widget: Revenue Projection Model
class RevenueProjectionModel extends StatelessWidget {
  const RevenueProjectionModel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.yellow.withValues(alpha: 0.3)),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.query_stats, color: Colors.yellow, size: 48),
            SizedBox(height: 16),
            Text('REVENUE PROJECTION MODEL', 
              style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
            Text('Predictive Fiscal Intelligence Hydration', 
              style: TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

/// Specialized Aura Widget: Live Dispatch Map
class LiveDispatchMap extends StatelessWidget {
  const LiveDispatchMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.5)),
      ),
      child: Stack(
        children: [
          Center(
            child: Icon(Icons.map, color: Colors.blue.withValues(alpha: 0.2), size: 120),
          ),
          const Positioned(
            top: 16,
            left: 16,
            child: Text('LIVE DISPATCH RADAR', 
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, letterSpacing: 1)),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text('ACTIVE UNITS: 14', 
                style: TextStyle(color: Colors.blue, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

/// Specialized Aura Widget: Robotic Dispensing Interface
class RoboticDispensingInterface extends StatelessWidget {
  const RoboticDispensingInterface({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.withValues(alpha: 0.1), Colors.black.withValues(alpha: 0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.teal.withValues(alpha: 0.3)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.precision_manufacturing, color: Colors.teal, size: 40),
              Text('ARM STATUS', style: TextStyle(fontSize: 10, color: Colors.grey)),
              Text('NOMINAL', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
            ],
          ),
          VerticalDivider(indent: 40, endIndent: 40),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.medication, color: Colors.teal, size: 40),
              Text('THROUGHPUT', style: TextStyle(fontSize: 10, color: Colors.grey)),
              Text('45 PKG/MIN', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}


/// A generic, high-fidelity stub for Aura components.
class AuraComponentStub extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const AuraComponentStub({
    required this.title,
    required this.icon,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(title, 
              style: TextStyle(
                fontSize: 10, 
                fontWeight: FontWeight.bold, 
                color: color,
                letterSpacing: 1.5,
              )),
          ],
        ),
      ),
    );
  }
}
