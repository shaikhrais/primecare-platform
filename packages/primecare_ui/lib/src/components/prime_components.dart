// Governance - Category: view | Purpose: [Component] - Standardized Card for PrimeCare Platform.
import 'package:primecare_ui/primecare_ui.dart';

/// [Component] - Standardized Card for PrimeCare Platform.
class PrimeCareCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final VoidCallback? onTap;

  const PrimeCareCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      margin: margin,
      decoration: BoxDecoration(boxShadow: theme.shadowsSurface1),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(theme.radiusMd),
          side: BorderSide(color: theme.colors.divider),
        ),
        color: color ?? Colors.white,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(theme.radiusMd),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(20),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// [Component] - Standardized TextField for PrimeCare Platform.
class PrimeCareTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final bool isPassword;
  final int maxLines;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final String? dataCy;

  const PrimeCareTextField({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.isPassword = false,
    this.maxLines = 1,
    this.validator,
    this.onChanged,
    this.dataCy,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final widget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.typography.labelMedium),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          maxLines: maxLines,
          onChanged: onChanged,
          validator: validator,
          style: theme.typography.bodyMedium,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(theme.radiusDefault),
              borderSide: BorderSide(color: theme.colors.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(theme.radiusDefault),
              borderSide: BorderSide(color: theme.colors.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(theme.radiusDefault),
              borderSide: BorderSide(color: theme.colors.primary, width: 2),
            ),
          ),
        ),
      ],
    );

    if (dataCy != null) {
      return Cy(id: dataCy!, child: widget);
    }
    return widget;
  }
}

/// [Component] - Standardized Dashboard Loading State.
class DashboardLoadingWidget extends StatelessWidget {
  const DashboardLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

/// [Component] - Standardized Dashboard Error State.
class DashboardErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const DashboardErrorWidget({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LucideIcons.alertTriangle, size: 48, color: theme.colors.error),
          const SizedBox(height: 16),
          Text('Operational Anomaly Detected', style: theme.typography.h3),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.typography.bodyMedium.copyWith(
              color: theme.colors.onSurfaceVariant,
            ),
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 24),
            ElevatedButton(key: const Key('prime_components_elevatedbutton_button_1'), 
              onPressed: onRetry,
              child: const Text('Retry Hydration'),
            ),
          ],
        ],
      ),
    );
  }
}

/// [Component] - Section Header for Dashboards.
class DashboardSectionHeader extends StatelessWidget {
  final String title;

  const DashboardSectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title.toUpperCase(),
        style: theme.typography.labelBold.copyWith(
          color: theme.colors.primary,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}

/// [Component] - Grid for Dashboard KPIs.
class DashboardKpiGrid extends StatelessWidget {
  final DashboardMetrics metrics;

  const DashboardKpiGrid({super.key, required this.metrics});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: metrics.kpis.length,
      itemBuilder: (context, index) {
        final key = metrics.kpis.keys.elementAt(index);
        final value = metrics.kpis[key];
        return PrimeCareCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(key, style: context.theme.typography.labelMedium),
              const SizedBox(height: 4),
              Text(value.toString(), style: context.theme.typography.h2),
            ],
          ),
        );
      },
    );
  }
}

/// [Component] - Card for AI Insights.
class ActionableInsightCard extends StatelessWidget {
  final IntelligenceInsight insight;

  const ActionableInsightCard({super.key, required this.insight});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final color = _getImpactColor(theme, insight.impact);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: PrimeCareCard(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 4,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(insight.title, style: theme.typography.h3),
                  const SizedBox(height: 4),
                  Text(
                    insight.summary,
                    style: theme.typography.bodyMedium.copyWith(
                      color: theme.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getImpactColor(PrimeThemeData theme, InsightImpact impact) {
    switch (impact) {
      case InsightImpact.positive:
        return Colors.green;
      case InsightImpact.caution:
        return theme.colors.warning;
      case InsightImpact.critical:
        return theme.colors.error;
      case InsightImpact.info:
      default:
        return theme.colors.primary;
    }
  }
}

/// [Component] - Manifest showing system integrity state.
class SystemIntegrityManifest extends StatelessWidget {
  const SystemIntegrityManifest({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colors.primary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(theme.radiusMd),
          border: Border.all(
            color: theme.colors.primary.withValues(alpha: 0.1),
          ),
        ),
        child: Row(
          children: [
            Icon(LucideIcons.shieldCheck, color: theme.colors.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'auth_success_parity_title'.tr(),
                    style: theme.typography.h3.copyWith(
                      color: theme.colors.primary,
                    ),
                  ),
                  Text(
                    'auth_success_parity_subtitle'.tr(),
                    style: theme.typography.bodySmall.copyWith(
                      color: theme.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrimeCareKpiCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const PrimeCareKpiCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(theme.radiusSm),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const Spacer(),
          Text(title, style: theme.typography.labelMedium),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class PrimeCareChartCard extends StatelessWidget {
  final String title;
  final Widget chart;

  const PrimeCareChartCard({
    super.key,
    required this.title,
    required this.chart,
  });

  @override
  Widget build(BuildContext context) {
    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.theme.typography.h3),
          const SizedBox(height: 24),
          Expanded(child: chart),
        ],
      ),
    );
  }
}

/// [Component] - High-fidelity Stat Card for Dashboards.
class PrimeCareStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? deltaSuffix;
  final IconData icon;
  final Color iconColor;

  const PrimeCareStatCard({
    super.key,
    required this.title,
    required this.value,
    this.deltaSuffix,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.divider),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(theme.radiusSm),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              if (deltaSuffix != null && deltaSuffix!.isNotEmpty)
                Text(
                  deltaSuffix!,
                  style: theme.typography.labelBold.copyWith(
                    color: Colors.green,
                  ),
                ),
            ],
          ),
          const Spacer(),
          Text(title, style: theme.typography.labelMedium),
          const SizedBox(height: 4),
          Text(value, style: theme.typography.h2),
        ],
      ),
    );
  }
}

/// [Component] - Standardized Button for PrimeCare Platform.
class PrimeButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final bool isGhost;
  final String? dataCy;

  const PrimeButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.color,
    this.textColor,
    this.borderColor,
    this.isGhost = false,
    this.dataCy,
  });

  /// Factory for the standard primary button.
  factory PrimeButton.primary({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    IconData? icon,
    bool isLoading = false,
    bool isFullWidth = false,
    String? dataCy,
  }) {
    return PrimeButton(
      key: key,
      label: label,
      onPressed: onPressed,
      icon: icon,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      dataCy: dataCy,
    );
  }

  /// Factory for the secondary/outline button style.
  factory PrimeButton.secondary({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    IconData? icon,
    bool isLoading = false,
    bool isFullWidth = false,
    String? dataCy,
  }) {
    return PrimeButton(
      key: key,
      label: label,
      onPressed: onPressed,
      icon: icon,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      color: Colors.transparent,
      textColor: const Color(0xFF004AC6),
      borderColor: const Color(0xFF004AC6).withValues(alpha: 0.2),
      dataCy: dataCy,
    );
  }

  /// Factory for the ghost/text-only button style.
  factory PrimeButton.ghost({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    IconData? icon,
    bool isLoading = false,
    bool isFullWidth = false,
    String? dataCy,
  }) {
    return PrimeButton(
      key: key,
      label: label,
      onPressed: onPressed,
      icon: icon,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      color: Colors.transparent,
      textColor: const Color(0xFF434655),
      isGhost: true,
      dataCy: dataCy,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final buttonColor = color ?? theme.colors.primary;
    final actualTextColor =
        textColor ??
        (color == Colors.transparent
            ? theme.colors.primary
            : theme.colors.onPrimary);

    final child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading)
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: actualTextColor,
            ),
          )
        else if (icon != null) ...[
          Icon(icon, size: 18, color: actualTextColor),
          const SizedBox(width: 8),
        ],
        if (!isLoading)
          Text(
            label,
            style: theme.typography.labelBold.copyWith(color: actualTextColor),
          ),
      ],
    );

    Widget buildButtonWidget() {
      if (isGhost) {
        return TextButton(key: const Key('prime_components_textbutton_button_1'), 
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(theme.radiusDefault),
            ),
          ),
          child: child,
        );
      }

      return SizedBox(
        width: isFullWidth ? double.infinity : null,
        child: ElevatedButton(key: const Key('prime_components_elevatedbutton_button_2'), 
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            foregroundColor: actualTextColor,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(theme.radiusDefault),
              side: borderColor != null
                  ? BorderSide(color: borderColor!)
                  : BorderSide.none,
            ),
            elevation: 0,
          ),
          child: child,
        ),
      );
    }

    final buttonWidget = buildButtonWidget();
    if (dataCy != null) {
      return Cy(id: dataCy!, child: buttonWidget);
    }
    return buttonWidget;
  }
}

typedef PrimeCareButton = PrimeButton;

/// [Component] - Standardized Emergency FAB for PrimeCare Platform.
class EmergencyFab extends StatelessWidget {
  final VoidCallback? onPressed;

  const EmergencyFab({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return FloatingActionButton.large(
      onPressed: onPressed,
      backgroundColor: theme.colors.error,
      foregroundColor: Colors.white,
      child: const Icon(LucideIcons.alertTriangle),
    );
  }
}
