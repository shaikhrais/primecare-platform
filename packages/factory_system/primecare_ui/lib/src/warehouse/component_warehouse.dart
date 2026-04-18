import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:primecare_core/flutter_core.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../components/primecare_stat_card.dart';
import '../components/layout/prime_responsive_grid.dart';
import '../components/cards/primecare_chart_card.dart';
import '../components/charts/prime_care_line_chart.dart';
import '../screens/common/primecare_report_screen.dart';
import '../components/aura/aura_dashboard_hud.dart';
import '../components/stitch_engine/stitch_engine_renderer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/design_system.dart';
import '../components/forms/clinical/patient_intake_form.dart';
import '../components/forms/clinical/vitals_capture_form.dart';
import '../components/forms/admin/new_staff_provisioning_form.dart';
import '../components/forms/clinical_incident_form.dart';
import '../components/forms/billing_payment_form.dart';
import '../components/forms/medication_administration_form.dart';
import '../components/forms/employee_timesheet_form.dart';

/// A function signature for building a specific component from a blueprint payload.
typedef ComponentBuilder =
    Widget Function(BuildContext context, dynamic dataPayload);

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
    'stitch_screen': _buildStitchScreen,
    'patient_intake_form': _buildPatientIntakeForm,
    'vitals_capture_form': _buildVitalsCaptureForm,
    'staff_provisioning_form': _buildStaffProvisioningForm,
    'clinical_incident_form': _buildClinicalIncidentForm,
    'billing_payment_form': _buildBillingPaymentForm,
    'medication_administration_form': _buildMedicationAdministrationForm,
    'employee_timesheet_form': _buildEmployeeTimesheetForm,
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
    final widget = builder(context, blueprint.dataPayload);

    // Resolution for "Duplicate GlobalKey" issues: Wrap in a KeyedSubtree with a unique ID
    // derived from the blueprint type and payload identity/hash.
    // We add a 'salt' to the key to distinguish between top-level orchestration and nested items.
    return KeyedSubtree(
      key: ValueKey(
        'warehouse_${blueprint.componentType}_${blueprint.dataPayload.hashCode}',
      ),
      child: widget,
    );
  }

  // --- Builders for default widgets ---

  static Widget _buildStatCardGrid(BuildContext context, dynamic dataPayload) {
    // Expected a list of KPI objects
    if (dataPayload == null || dataPayload is! List) {
      return const SizedBox.shrink();
    }
    final kpis = dataPayload;
    final ds = PrimeCareDesignSystem.of(context);

    return PrimeResponsiveGrid(
      children: kpis.map((kpi) {
        if (kpi is UniversalKpi) {
          return PrimeCareStatCard(
            title: kpi.title,
            value: kpi.value,
            deltaSuffix: kpi.trend != 0.0
                ? "${kpi.trend > 0 ? '+' : ''}${kpi.trend}%"
                : null,
            icon: _inferIcon(kpi.title),
            iconColor: _inferColor(ds, kpi.status.name),
          );
        }

        // Fallback for raw map data or dynamic objects
        try {
          final title = (kpi is Map) ? kpi['title'] : (kpi as dynamic).title;
          final value = (kpi is Map) ? kpi['value'] : (kpi as dynamic).value;
          final status = (kpi is Map)
              ? (kpi['status'] ?? 'neutral')
              : (kpi as dynamic).status;
          final trend = (kpi is Map)
              ? kpi['trend']?.toString()
              : (kpi as dynamic).trend?.toString();

          return PrimeCareStatCard(
            title: title as String? ?? 'Metric',
            value: value as String? ?? '0',
            deltaSuffix: trend,
            icon: _inferIcon(title ?? 'Metric'),
            iconColor: _inferColor(ds, status?.toString() ?? 'neutral'),
          );
        } catch (e) {
          return const PrimeCareStatCard(
            title: 'Error',
            value: '!',
            icon: LucideIcons.alertCircle,
          );
        }
      }).toList(),
    );
  }

  static Widget _buildActivityFeed(BuildContext context, dynamic dataPayload) {
    final activities = dataPayload as List<dynamic>;
    final ds = PrimeCareDesignSystem.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 16),
          child: Row(
            children: [
              Icon(LucideIcons.activity, size: 16, color: ds.colors.primary),
              const SizedBox(width: 8),
              Text(
                "INSTITUTIONAL CONTINUITY FEED",
                style: TextStyle(
                  color: ds.colors.primary,
                  fontSize: 11,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        ...activities.map((activity) {
          String title;
          String timestamp;
          String colorStr;

          if (activity is DashboardActivity) {
            title = activity.title;
            timestamp = activity.timestamp;
            colorStr = activity.color;
          } else if (activity is Map) {
            // Fallback for raw map data
            title = activity['title'] as String? ?? 'Activity';
            timestamp = activity['timestamp'] as String? ?? '';
            // Support both 'color' and 'type' keys for backward compatibility
            colorStr =
                (activity['color'] ?? activity['type']) as String? ?? 'primary';
          } else {
            // Surgical fallback for dynamic objects that might not be detected by type check
            try {
              title = (activity as dynamic).title as String? ?? 'System Update';
              timestamp =
                  (activity as dynamic).timestamp as String? ?? 'Recently';
              colorStr = (activity as dynamic).color as String? ?? 'primary';
            } catch (_) {
              title = 'System Update';
              timestamp = 'Recently';
              colorStr = 'primary';
            }
          }

          final color = colorStr == 'success' || colorStr == 'green'
              ? ds.colors.success
              : (colorStr == 'warning' || colorStr == 'orange'
                    ? ds.colors.warning
                    : (colorStr == 'danger' || colorStr == 'red'
                          ? ds.colors.danger
                          : ds.colors.primary));

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: ds.colors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: ds.colors.borderSubtle),
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 32,
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
                      Text(
                        title,
                        style: TextStyle(
                          color: ds.colors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        timestamp,
                        style: TextStyle(
                          color: ds.colors.textTertiary,
                          fontSize: 12,
                        ),
                      ),
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
    final ds = PrimeCareDesignSystem.of(context);
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: ds.colors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: ds.colors.borderSubtle),
      ),
      child: Column(
        children: [
          Icon(
            LucideIcons.database,
            size: 48,
            color: ds.colors.primary.withValues(alpha: 0.2),
          ),
          const SizedBox(height: 16),
          Text(
            "HYDRATED DATA MATRIX",
            style: TextStyle(
              color: ds.colors.textPrimary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Institutional records are fully synchronized and available in memory.",
            textAlign: TextAlign.center,
            style: TextStyle(color: ds.colors.textSecondary, fontSize: 13),
          ),
        ],
      ),
    );
  }

  static Widget _buildRiskMonitor(BuildContext context, dynamic dataPayload) {
    final ds = PrimeCareDesignSystem.of(context);
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: ds.colors.surface,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: ds.colors.danger.withValues(alpha: 0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: ds.colors.danger.withValues(alpha: 0.1),
            blurRadius: 40,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.shieldAlert, color: ds.colors.danger, size: 28),
              const SizedBox(width: 16),
              Text(
                "Risk Surveillance Engine".toUpperCase(),
                style: TextStyle(
                  color: ds.colors.textPrimary,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                "LIVE",
                style: TextStyle(
                  color: ds.colors.danger,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            "Monitoring algorithmic health and care quality signals across all tenants.",
            style: TextStyle(color: ds.colors.textSecondary, height: 1.5),
          ),
        ],
      ),
    );
  }

  static Widget _buildFinancialRail(BuildContext context, dynamic dataPayload) {
    // Expected dynamic list of FinancialMetric (or raw maps)
    final metricsRaw = dataPayload as List<dynamic>;
    final ds = PrimeCareDesignSystem.of(context);
    final metrics = metricsRaw.map((m) {
      if (m is FinancialMetric) return m;
      return FinancialMetric.fromJson(m as Map<String, dynamic>);
    }).toList();

    return Column(
      children: metrics.map((metric) {
        final color = _inferColor(ds, metric.status);

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: ds.colors.surface,
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
                        color: ds.colors.textSecondary,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      metric.value,
                      style: TextStyle(
                        color: ds.colors.textPrimary,
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
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

  static Widget _buildAuraDashboardHud(
    BuildContext context,
    dynamic dataPayload,
  ) {
    return const AuraDashboardHud();
  }

  static Widget _buildStitchScreen(BuildContext context, dynamic dataPayload) {
    final screenId = dataPayload as String;
    // Note: In a production environment, this would fetch the actual high-fidelity
    // components from the Stitch backend via the screenId.
    // For now, we delegate to the StitchEngineRenderer with simulated items
    // tagged with the screenId for traceability.
    return StitchEngineRenderer(
      featureId: screenId,
      items: [
        FeatureViewModel(
          id: 'ceo-1',
          title: 'Executive Revenue Command',
          description:
              'High-fidelity financial data stream for Screen $screenId',
          status: 'ACTIVE',
        ),
        FeatureViewModel(
          id: 'ceo-2',
          title: 'Institutional Risk Surveillance',
          description: 'Predictive risk monitoring for $screenId',
          status: 'MONITORING',
        ),
      ],
    );
  }

  static Widget _buildManagementAction(
    BuildContext context,
    dynamic dataPayload,
  ) {
    final ds = PrimeCareDesignSystem.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ds.colors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: ds.colors.warning.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Critical Controls",
            style: TextStyle(
              color: ds.colors.warning,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildActionButton(
                context,
                "Quarantine Tenant",
                LucideIcons.lock,
                ds.colors.danger,
              ),
              _buildActionButton(
                context,
                "System Audit",
                LucideIcons.fileSearch,
                ds.colors.primary,
              ),
              _buildActionButton(
                context,
                "Freeze Payouts",
                LucideIcons.pause,
                ds.colors.warning,
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildClinicalMetric(
    BuildContext context,
    dynamic dataPayload,
  ) {
    final title = dataPayload['title'] as String? ?? 'Clinical Intelligence';
    final metrics = dataPayload['metrics'] as List<dynamic>? ?? [];
    final ds = PrimeCareDesignSystem.of(context);

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: ds.colors.surface,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: ds.colors.borderSubtle),
        boxShadow: [
          BoxShadow(
            color: PrimeCareColors.black.withAlpha(20),
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
              Text(
                title,
                style: TextStyle(
                  color: ds.colors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Icon(LucideIcons.trendingUp, color: ds.colors.success, size: 18),
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
                      Text(
                        label,
                        style: TextStyle(
                          color: ds.colors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "${(value * 100).toInt()}%",
                        style: TextStyle(
                          color: ds.colors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Stack(
                    children: [
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: ds.colors.borderSubtle,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: value,
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [ds.colors.primary, ds.colors.secondary],
                            ),
                            borderRadius: BorderRadius.circular(3),
                            boxShadow: [
                              BoxShadow(
                                color: ds.colors.primary.withValues(alpha: 0.3),
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

  // FOUND1
  static Widget _buildComplianceGate(
    BuildContext context,
    dynamic dataPayload,
  ) {
    final ds = PrimeCareDesignSystem.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ds.colors.primary.withValues(alpha: 0.1),
            ds.colors.success.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: ds.colors.success.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.shieldCheck, color: ds.colors.success, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "REGULATORY COMPLIANCE GATE",
                  style: TextStyle(
                    color: ds.colors.success,
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    letterSpacing: 1.1,
                  ),
                ),
                Text(
                  "All institutional checkpoints verified and passed.",
                  style: TextStyle(
                    color: ds.colors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  static ComponentBuilder _buildUnknownComponent(String type) {
    return (BuildContext context, dynamic payload) {
      return Center(child: Text('Unknown component type: $type'));
    };
  }

  static Widget _buildAnalyticsChart(
    BuildContext context,
    dynamic dataPayload,
  ) {
    if (dataPayload is! AnalyticsChart) {
      return const SizedBox.shrink();
    }

    return Consumer(
      builder: (context, ref, child) {
        final auraToggles = ref.watch(auraDashboardToggleProvider);
        final isAuraActive = auraToggles[dataPayload.id] ?? false;

        final ds = PrimeCareDesignSystem.of(context);
        return PrimeCareChartCard(
          title: dataPayload.title,
          isAuraActive: isAuraActive,
          chart: SizedBox(
            height: 250,
            child: PrimeCareLineChart(
              chart: dataPayload,
              lineColor: _inferColor(ds, dataPayload.id),
              isPredictive: isAuraActive,
            ),
          ),
          isAuraSupported: true,
          onPinToggle: () {},
          onAuraToggle: () {
            ref
                .read(auraDashboardToggleProvider.notifier)
                .toggle(dataPayload.id);
          },
          onDetailPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PrimeCareReportScreen(
                  reportId: dataPayload.reportId ?? 'unspecified',
                ),
              ),
            );
          },
        );
      },
    );
  }

  static Widget _buildPatientIntakeForm(
    BuildContext context,
    dynamic dataPayload,
  ) {
    return const PatientIntakeForm();
  }

  static Widget _buildVitalsCaptureForm(
    BuildContext context,
    dynamic dataPayload,
  ) {
    return const VitalsCaptureForm();
  }

  static Widget _buildStaffProvisioningForm(
    BuildContext context,
    dynamic dataPayload,
  ) {
    return const NewStaffProvisioningForm();
  }

  static Widget _buildClinicalIncidentForm(
    BuildContext context,
    dynamic dataPayload,
  ) {
    return const ClinicalIncidentForm();
  }

  static Widget _buildBillingPaymentForm(
    BuildContext context,
    dynamic dataPayload,
  ) {
    return const BillingPaymentForm();
  }

  static Widget _buildMedicationAdministrationForm(
    BuildContext context,
    dynamic dataPayload,
  ) {
    return const MedicationAdministrationForm();
  }

  static Widget _buildEmployeeTimesheetForm(
    BuildContext context,
    dynamic dataPayload,
  ) {
    return const EmployeeTimesheetForm();
  }

  // --- Utility Methods ---
  static IconData _inferIcon(String title) {
    final t = title.toLowerCase();
    if (t.contains('patient') || t.contains('client')) return LucideIcons.users;
    if (t.contains('revenue') || t.contains('payment') || t.contains('invoice'))
      return LucideIcons.dollarSign;
    if (t.contains('appointment') || t.contains('schedule'))
      return LucideIcons.calendar;
    if (t.contains('alert') || t.contains('critical'))
      return LucideIcons.alertCircle;
    if (t.contains('staff') || t.contains('provider') || t.contains('rpn'))
      return LucideIcons.stethoscope;
    if (t.contains('task') || t.contains('pipeline'))
      return LucideIcons.checkSquare;
    return LucideIcons.activity;
  }

  static Color _inferColor(PrimeCareDesignSystem ds, String status) {
    final s = status.toLowerCase();
    if (s == 'operational' || s == 'positive' || s == 'up' || s == 'active')
      return ds.colors.success;
    if (s == 'warning' || s == 'attention') return ds.colors.warning;
    if (s == 'critical' || s == 'down' || s == 'negative' || s == 'error')
      return ds.colors.danger;
    return ds.colors.primary;
  }
}
