// Layer: 02_COMPONENTS
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';

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
        border: Border.all(color: theme.colors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
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

/// Placeholder for charts until specific ones are implemented or restored.
class PrimeCareLineChart extends StatelessWidget {
  final AnalyticsChart chart;
  final Color? lineColor;

  const PrimeCareLineChart({required this.chart, this.lineColor, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: theme.colors.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(theme.radii.md),
      ),
      child: const Center(child: Text('Line Chart Visualization')),
    );
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

enum AppShellType { desktop, mobile, tablet, minimal, admin }

/// Master Layout wrapper for consistency.
class MasterLayout extends StatelessWidget {
  final Widget child;
  final AppShellType? shellType;
  const MasterLayout({required this.child, this.shellType, super.key});

  @override
  Widget build(BuildContext context) {
    return child;
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
              Text(title, style: theme.typography.labelMedium),
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
              Row(
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 16, color: theme.colors.primary),
                    SizedBox(width: theme.spacing.xs),
                  ],
                  Text(title, style: theme.typography.labelMedium),
                ],
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
          Text(value, style: theme.typography.h3),
          if (subtitle.isNotEmpty) ...[
            SizedBox(height: theme.spacing.xs),
            Text(
              subtitle,
              style: theme.typography.labelSmall.copyWith(
                color: theme.colors.slateGray,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Aura real-time intelligence HUD.
class AuraDashboardHud extends StatelessWidget {
  const AuraDashboardHud({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // Stub for real-time telemetry HUD
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
class BaseLayoutShell extends StatelessWidget {
  final Widget child;
  final String currentPath;

  const BaseLayoutShell({
    required this.child,
    required this.currentPath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return child; // Stub for shell
  }
}

/// Automatically dims or disables components based on subsystem health.
class WidgetModulationGovernor extends StatelessWidget {
  final String subsystem;
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
class StitchEngineRenderer extends StatelessWidget {
  final String featureId;
  final List<dynamic> items;

  const StitchEngineRenderer({
    required this.featureId,
    required this.items,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Stitch Renderer: $featureId'));
  }
}

/// Global registry for UI components and builders.
class ComponentWarehouse {
  static final Map<String, Widget Function(BuildContext, dynamic)> _registry =
      {};

  static void register(
    String id,
    Widget Function(BuildContext, dynamic) builder,
  ) {
    _registry[id] = builder;
  }

  static Widget Function(BuildContext, dynamic)? getBuilder(String id) {
    return _registry[id];
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
          color: (color ?? theme.colors.primary).withAlpha(20),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: (color ?? theme.colors.primary).withAlpha(50),
          ),
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

  const PrimeCareTextField({
    required this.label,
    this.placeholder,
    this.controller,
    this.onChanged,
    this.maxLines = 1,
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
        TextField(
          controller: controller,
          onChanged: onChanged,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: placeholder,
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
