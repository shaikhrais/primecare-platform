import 'package:flutter/material.dart';
import 'package:primecare_core/flutter_core.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../components/primecare_stat_card.dart';
import '../components/layout/prime_responsive_grid.dart';
import '../components/cards/primecare_chart_card.dart';
import '../components/charts/prime_care_line_chart.dart';
import '../screens/common/primecare_report_screen.dart';
import '../components/aura/aura_dashboard_hud.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A function signature for building a specific component from a blueprint payload.
typedef ComponentBuilder = Widget Function(BuildContext context, dynamic dataPayload);

/// A centralized registry to securely map component string types to their respective Builders.
/// This replaces large switch statements and is O(1) time complexity.
class ComponentWarehouse {
  static final Map<String, ComponentBuilder> _registry = {
    'stat_card_grid': _buildStatCardGrid,
    'activity_feed': _buildActivityFeed,
    'data_table': _buildDataTable,
    'risk_monitor': _buildRiskMonitor,
    'financial_rail': _buildFinancialRail,
    'management_action': _buildManagementAction,
    'clinical_metric': _buildClinicalMetric,
    'compliance_gate': _buildComplianceGate,
    'analytics_chart': _buildAnalyticsChart,
    'aura_dashboard_hud': _buildAuraDashboardHud,
  };

  /// Register a new component dynamically (could be used for lazy-loaded plugins).
  static void registerComponent(String type, ComponentBuilder builder) {
    _registry[type] = builder;
  }

  /// Retrieve the builder for a component type. Returns a fallback builder if not found.
  static ComponentBuilder getBuilder(String componentType) {
    return _registry[componentType] ?? _buildUnknownComponent(componentType);
  }

  /// Extracts the required Builder and creates the widget safely.
  static Widget build(BuildContext context, UIComponentBlueprint blueprint) {
    final builder = getBuilder(blueprint.componentType);
    return builder(context, blueprint.dataPayload);
  }


  // --- Builders for default widgets ---

  static Widget _buildStatCardGrid(BuildContext context, dynamic dataPayload) {
    // Expected a list of KPI objects
    final kpis = dataPayload as List<dynamic>; 
    
    return PrimeResponsiveGrid(
      children: kpis.map((kpi) {
        if (kpi is UniversalKpi) {
          return PrimeCareStatCard(
            title: kpi.title,
            value: kpi.value,
            deltaSuffix: kpi.trend != 0.0 ? "${kpi.trend > 0 ? '+' : ''}${kpi.trend}%" : null,
            icon: _inferIcon(kpi.title),
            iconColor: _inferColor(kpi.status.name),
          );
        }
        
        // Fallback for raw map data
        final title = kpi['title'] as String? ?? 'Metric';
        final value = kpi['value'] as String? ?? '0';
        final status = kpi['status'] as String? ?? 'neutral';
        final trend = kpi['trend']?.toString();
        
        return PrimeCareStatCard(
          title: title,
          value: value,
          deltaSuffix: trend,
          icon: _inferIcon(title),
          iconColor: _inferColor(status),
        );
      }).toList(),
    );
  }

  static Widget _buildActivityFeed(BuildContext context, dynamic dataPayload) {
    final activities = dataPayload as List<dynamic>;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8, bottom: 12),
          child: Text("Operational Continuity", style: TextStyle(color: Colors.white70, fontSize: 13, letterSpacing: 1.2, fontWeight: FontWeight.bold)),
        ),
        ...activities.map((activity) {
          final type = activity['type'] as String? ?? 'info';
          final color = type == 'success' ? Colors.tealAccent : (type == 'warning' ? Colors.orangeAccent : Colors.blueAccent);
          
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.withAlpha(100),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(activity['title'] as String,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                      Text(activity['timestamp'] as String,
                          style: TextStyle(
                              color: Colors.white.withAlpha(100),
                              fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  static Widget _buildDataTable(BuildContext context, dynamic dataPayload) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(12),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withAlpha(25)),
      ),
      child: const Center(child: Text("Data Table - Assembled", style: TextStyle(color: Colors.white))),
    );
  }

  static Widget _buildRiskMonitor(BuildContext context, dynamic dataPayload) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.redAccent.withAlpha(50), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.redAccent.withAlpha(20),
            blurRadius: 40,
            spreadRadius: 5,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.shieldAlert, color: Colors.redAccent, size: 28),
              const SizedBox(width: 16),
              Text(
                "Risk Surveillance Engine".toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const Text("LIVE", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w900)),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            "Monitoring algorithmic health and care quality signals across all tenants.",
            style: TextStyle(color: Colors.white70, height: 1.5),
          ),
        ],
      ),
    );
  }

  static Widget _buildFinancialRail(BuildContext context, dynamic dataPayload) {
    // Expected dynamic list of FinancialMetric (or raw maps)
    final metricsRaw = dataPayload as List<dynamic>;
    final metrics = metricsRaw.map((m) {
      if (m is FinancialMetric) return m;
      return FinancialMetric.fromJson(m as Map<String, dynamic>);
    }).toList();

    return Column(
      children: metrics.map((metric) {
        final color = _inferColor(metric.status);
        
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A).withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: color.withValues(alpha: 0.2)),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.05),
                blurRadius: 15,
                spreadRadius: -5,
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(LucideIcons.landmark, color: color, size: 20),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      metric.label.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      metric.value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              if (metric.trend != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    metric.trend!,
                    style: TextStyle(
                      color: color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  static Widget _buildAuraDashboardHud(BuildContext context, dynamic dataPayload) {
    return const AuraDashboardHud();
  }

  static Widget _buildManagementAction(BuildContext context, dynamic dataPayload) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(10),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.orangeAccent.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Critical Controls", style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            children: [
              _buildActionButton("Quarantine Tenant", LucideIcons.lock, Colors.redAccent),
              _buildActionButton("System Audit", LucideIcons.fileSearch, Colors.blueAccent),
              _buildActionButton("Freeze Payouts", LucideIcons.pause, Colors.orangeAccent),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildClinicalMetric(BuildContext context, dynamic dataPayload) {
    final title = dataPayload['title'] as String? ?? 'Clinical Intelligence';
    final metrics = dataPayload['metrics'] as List<dynamic>? ?? [];

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFF1B262C),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const Spacer(),
              const Icon(LucideIcons.trendingUp, color: Colors.tealAccent, size: 18),
            ],
          ),
          const SizedBox(height: 24),
          ...metrics.map((m) {
            final label = m['label'] as String;
            final value = (m['value'] as num).toDouble();
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                      Text("${(value * 100).toInt()}%", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Stack(
                    children: [
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(10),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: value,
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.tealAccent, Color(0xFF2193b0)],
                            ),
                            borderRadius: BorderRadius.circular(3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.tealAccent.withAlpha(80),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  static Widget _buildComplianceGate(BuildContext context, dynamic dataPayload) {
     return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.indigo.withAlpha(30),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.indigoAccent.withAlpha(50)),
      ),
      child: const Center(child: Text("Compliance Gate - Verified", style: TextStyle(color: Colors.indigoAccent))),
    );
  }

  static Widget _buildActionButton(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withAlpha(40)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }

  static ComponentBuilder _buildUnknownComponent(String type) {
    return (BuildContext context, dynamic payload) {
       return Center(
         child: Text('Unknown component type: $type'),
       );
    };
  }

  static Widget _buildAnalyticsChart(BuildContext context, dynamic dataPayload) {
    if (dataPayload is! AnalyticsChart) {
      return const SizedBox.shrink();
    }

    return Consumer(
      builder: (context, ref, child) {
        final auraToggles = ref.watch(auraDashboardToggleProvider);
        final isAuraActive = auraToggles[dataPayload.id] ?? false;

        return PrimeCareChartCard(
          title: dataPayload.title,
          isAuraActive: isAuraActive,
          chart: SizedBox(
            height: 250,
            child: PrimeCareLineChart(
              chart: dataPayload,
              lineColor: _inferColor(dataPayload.id),
              isPredictive: isAuraActive,
            ),
          ),
          isAuraSupported: true,
          onPinToggle: () {},
          onAuraToggle: () {
            ref.read(auraDashboardToggleProvider.notifier).toggle(dataPayload.id);
          },
          onDetailPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PrimeCareReportScreen(
                    reportId: dataPayload.reportId ?? 'unspecified'),
              ),
            );
          },
        );
      },
    );
  }

  // --- Utility Methods ---
  static IconData _inferIcon(String title) {
    final t = title.toLowerCase();
    if (t.contains('patient') || t.contains('client')) return LucideIcons.users;
    if (t.contains('revenue') || t.contains('payment') || t.contains('invoice')) return LucideIcons.dollarSign;
    if (t.contains('appointment') || t.contains('schedule')) return LucideIcons.calendar;
    if (t.contains('alert') || t.contains('critical')) return LucideIcons.alertCircle;
    if (t.contains('staff') || t.contains('provider') || t.contains('rpn')) return LucideIcons.stethoscope;
    if (t.contains('task') || t.contains('pipeline')) return LucideIcons.checkSquare;
    return LucideIcons.activity;
  }

  static Color _inferColor(String status) {
    final s = status.toLowerCase();
    if (s == 'operational' || s == 'positive' || s == 'up' || s == 'active') return Colors.greenAccent;
    if (s == 'warning' || s == 'attention') return Colors.orangeAccent;
    if (s == 'critical' || s == 'down' || s == 'negative') return Colors.redAccent;
    return Colors.tealAccent;
  }
}
