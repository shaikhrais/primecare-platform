import 'package:flutter/material.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class KPICardData {
  final String title;
  final String value;
  final IconData? icon;
  final dynamic trend;
  final String? trendLabel;

  const KPICardData({
    required this.title,
    required this.value,
    this.icon,
    this.trend,
    this.trendLabel,
  });
}

class PageTemplate extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;
  final List<Widget>? actions;
  final Widget? body;
  
  final Widget? headerTrailing;
  
  // Alternative content properties for custom code pages
  final List<KPICardData>? kpiCards;
  final List<Widget>? mainContent;
  final List<Widget>? sidebarContent;

  const PageTemplate({
    super.key,
    required this.title,
    required this.subtitle,
    this.body,
    this.icon,
    this.actions,
    this.headerTrailing,
    this.kpiCards,
    this.mainContent,
    this.sidebarContent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header Area
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: PrimeCareTheme.spacing6,
            vertical: PrimeCareTheme.spacing5,
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                Container(
                  padding: const EdgeInsets.all(PrimeCareTheme.spacing3),
                  decoration: BoxDecoration(
                    color: PrimeCareTheme.primaryContainer,
                    borderRadius: BorderRadius.circular(PrimeCareTheme.radiusMd),
                  ),
                  child: Icon(
                    icon,
                    color: PrimeCareTheme.onPrimaryContainer,
                    size: 24,
                  ),
                ),
                const SizedBox(width: PrimeCareTheme.spacing4),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: PrimeCareTheme.headlineMedium,
                    ),
                    const SizedBox(height: PrimeCareTheme.spacing1),
                    Text(
                      subtitle,
                      style: PrimeCareTheme.bodyMedium.copyWith(
                        color: PrimeCareTheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (actions != null) ...[
                const SizedBox(width: PrimeCareTheme.spacing4),
                ...actions!.map((action) => Padding(
                      padding: const EdgeInsets.only(left: PrimeCareTheme.spacing2),
                      child: action,
                    )),
              ],
            ],
          ),
        ),
        
        // Main Content Area
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: PrimeCareTheme.spacing6),
            child: body ?? _buildAlternativeBody(context),
          ),
        ),
      ],
    );
  }
  
  
  double _parseTrend(dynamic trend) {
    if (trend == null) return 0.0;
    if (trend is double) return trend;
    if (trend is int) return trend.toDouble();
    if (trend is String) {
      final str = trend.replaceAll('%', '').replaceAll('+', '').trim();
      return double.tryParse(str) ?? 0.0;
    }
    return 0.0;
  }

  Widget _buildAlternativeBody(BuildContext context) {
    if (kpiCards == null && mainContent == null && sidebarContent == null) {
      return const SizedBox.shrink();
    }
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main Area
        Expanded(
          flex: 3,
          child: ListView(
            children: [
              if (kpiCards != null && kpiCards!.isNotEmpty) ...[
                LayoutBuilder(
                  builder: (context, constraints) {
                    final int crossAxisCount = constraints.maxWidth < 600 ? 1 : (constraints.maxWidth < 900 ? 2 : 4);
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: PrimeCareTheme.spacing4,
                        mainAxisSpacing: PrimeCareTheme.spacing4,
                        childAspectRatio: 2.0,
                      ),
                      itemCount: kpiCards!.length,
                      itemBuilder: (context, index) {
                        return _buildKpiCard(kpiCards![index]);
                      },
                    );
                  }
                ),
                const SizedBox(height: PrimeCareTheme.spacing5),
              ],
              if (mainContent != null) ...mainContent!,
            ],
          ),
        ),
        
        // Sidebar Area
        if (sidebarContent != null && sidebarContent!.isNotEmpty) ...[
          const SizedBox(width: PrimeCareTheme.spacing5),
          Expanded(
            flex: 1,
            child: ListView(
              children: sidebarContent!,
            ),
          ),
        ],
      ],
    );
  }
  
  Widget _buildKpiCard(KPICardData data) {
    return Container(
      padding: const EdgeInsets.all(PrimeCareTheme.spacing4),
      decoration: BoxDecoration(
        color: PrimeCareTheme.surface,
        borderRadius: BorderRadius.circular(PrimeCareTheme.radiusLg),
        border: Border.all(color: PrimeCareTheme.outlineVariant.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  data.title,
                  style: PrimeCareTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (data.icon != null)
                Icon(data.icon, color: PrimeCareTheme.outline, size: 20),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.value,
                style: PrimeCareTheme.headlineMedium,
              ),
              if (data.trend != null && data.trendLabel != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Icon(
                          (_parseTrend(data.trend) > 0) ? Icons.arrow_upward : Icons.arrow_downward,
                          size: 14,
                          color: (_parseTrend(data.trend) > 0) ? PrimeCareTheme.secondary : PrimeCareTheme.error,
                        ),
                        Text(
                          '${data.trend!.abs()}%',
                          style: PrimeCareTheme.labelMedium.copyWith(
                            color: (_parseTrend(data.trend) > 0) ? PrimeCareTheme.secondary : PrimeCareTheme.error,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      data.trendLabel!,
                      style: PrimeCareTheme.labelSmall.copyWith(
                        color: PrimeCareTheme.outline,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
