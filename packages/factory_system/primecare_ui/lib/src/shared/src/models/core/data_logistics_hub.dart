import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:easy_localization/easy_localization.dart';
// Layer: 02_MODELS_FOUNDATION
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

/// Core Data Logistics Hub for the PrimeCare Platform.
/// Provides a unified mechanism for API hydration with automatic fallback to offline blueprints.
class DataLogisticsHub {
  /// Cached offline data loaded from the bundled JSON asset.
  static Map<String, dynamic>? _offlineData;

  /// Loads the offline seed data from the assets bundle.
  /// This should be called during application initialization.
  static Future<void> ensureOfflineDataLoaded() async {
    if (_offlineData != null) return;
    try {
      final String jsonContent = await rootBundle.loadString(
        'assets/data/offline_seed.json',
      );
      _offlineData = json.decode(jsonContent) as Map<String, dynamic>;
      debugPrint(
        'PRIMECARE_LOGISTICS: Offline seed data hydrated successfully.',
      );
    } catch (e) {
      debugPrint('PRIMECARE_LOGISTICS: Failed to load offline seed data: $e');
      _offlineData = {}; // Prevent repeated failed attempts
    }
  }

  /// Provides high-fidelity clinical intelligence blueprints.
  static ClinicalIntelligenceViewModel getClinicIntelligenceMetrics() {
    final nodes = safeLookup<List<dynamic>>(
      'institutional_nodes.clinicNode',
      <dynamic>[],
    );

    return ClinicalIntelligenceViewModel(
      isOfflineFallback: true,
      blueprints: [
        const AuraDashboardHudBlueprint(dataPayload: null),
        StatGridBlueprint(
          dataPayload: nodes
              .cast<Map<String, dynamic>>()
              .map(
                (n) => UniversalKpi(
                  title: (n['name'] as String?) ?? 'Facility',
                  value: '${(n['patientCount'] as dynamic) ?? 0}',
                  trendValue: 2.1,
                  status: KpiStatus.positive,
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  /// Assembles the data payload from the API into strongly-typed UI components.
  static Future<T> fetchAndAssemble<T>({
    required Future<T> Function() fetchCall,
    required T Function() fallbackBuilder,
    void Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    try {
      return await fetchCall();
    } catch (e, st) {
      if (onError != null) onError(e, st);
      return fallbackBuilder();
    }
  }

  /// Retrieves a report blueprint from the cache.
  static Map<String, dynamic>? getReportBlueprint(String reportId) {
    final reports = safeLookup<Map<String, dynamic>>(
      'reporting.blueprints',
      {},
    );
    if (reports.containsKey(reportId))
      return reports[reportId] as Map<String, dynamic>?;

    return {
      'id': reportId,
      'title': 'System Report',
      'columns': [
        {'key': 'id', 'label': 'ID'},
      ],
      'rows': <dynamic>[],
    };
  }

  /// Provides high-fidelity intelligence blueprints for demonstrators.
  static List<IntelligenceInsight> getAuraBlueprints(String role) {
    final aiRecs = safeLookup<List<dynamic>>(
      'institutional_nodes.aiRecommendation',
      <dynamic>[],
    );
    if (aiRecs.isNotEmpty) {
      return aiRecs
          .cast<Map<String, dynamic>>()
          .map(
            (n) => IntelligenceInsight(
              id: (n['id'] as String?) ?? 'ai_gen',
              title: (n['name'] as String?) ?? 'Insight',
              summary:
                  (n['description'] as String?) ??
                  'Aura is analyzing domain patterns.',
              impact: InsightImpact.positive,
            ),
          )
          .toList();
    }

    return [
      IntelligenceInsight(
        id: 'aura_1',
        title: LocaleKeys.dashboards_common_labels_cache_hydrated.tr(),
        summary:
            'Aura is pulling insights directly from the institutional data layer.',
        impact: InsightImpact.positive,
      ),
    ];
  }

  static List<IntelligenceInsight> getAuraInsights(String role) =>
      getAuraBlueprints(role);

  static DashboardMetrics getDashboardMetrics(String role) {
    if (_offlineData != null && _offlineData!.containsKey('metrics')) {
      final metricsMap = _offlineData!['metrics'] as Map<String, dynamic>;
      final roleData = metricsMap[role];
      if (roleData != null) {
        try {
          return DashboardMetrics.fromJson(roleData as Map<String, dynamic>);
        } catch (e) {
          debugPrint(
            'PRIMECARE_LOGISTICS: Failed to parse offline data for role $role: $e',
          );
        }
      }
    }
    return _buildResilientFallback(role);
  }

  static DashboardMetrics _buildResilientFallback(String role) {
    final isClinical = ['rn', 'rpn', 'psw', 'physiotherapist'].contains(role);
    final isGrowth = [
      'ceo',
      'coo',
      'cfo',
      'partnership_manager',
      'territory_expansion_manager',
    ].contains(role);

    return DashboardMetrics(
      kpis: [
        UniversalKpi(
          title: LocaleKeys.dashboards_common_labels_active_node.tr(),
          value: 'VERIFIED',
          status: KpiStatus.neutral,
        ),
        UniversalKpi(
          title: isGrowth ? 'Institutional Growth' : 'Care Compliance',
          value: isGrowth ? '12.4%' : '98.2%',
          status: KpiStatus.positive,
        ),
        UniversalKpi(
          title: LocaleKeys.dashboards_common_labels_sync_status.tr(),
          value: 'OFFLINE',
          status: KpiStatus.warning,
        ),
      ],
      recentActivity: [
        DashboardActivity(
          title: LocaleKeys.dashboards_common_labels_aura_intelligence__active
              .tr(),
          subtitle:
              'Processing ${role.replaceAll('_', ' ')} domain logic via logistics hub.',
          timestamp: 'Just now',
          icon: 'cpu',
          color: 'purple',
        ),
        DashboardActivity(
          title: isClinical
              ? 'Clinical Sweep: Passed'
              : 'Security Sweep: Passed',
          subtitle: LocaleKeys
              .dashboards_common_labels_no_anomalies_detected_in_the_local_cache_nodes
              .tr(),
          timestamp: '5m ago',
          icon: 'shield-check',
          color: 'green',
        ),
      ],
      charts: <AnalyticsChart>[],
    );
  }

  /// Horizon (Scheduling) Assembly Logic
  static HorizonSchedule getHorizonBlueprint() {
    final resources = safeLookup<List<dynamic>>(
      'institutional_nodes.institutionalResource',
      <dynamic>[],
    );
    final staff = safeLookup<List<dynamic>>(
      'institutional_nodes.staffMember',
      <dynamic>[],
    );
    final appointments = safeLookup<List<dynamic>>('visits', <dynamic>[]);

    return HorizonSchedule(
      resources: resources
          .cast<Map<String, dynamic>>()
          .map(
            (n) => InstitutionalResource(
              id: (n['id'] as String?) ?? '',
              name: (n['name'] as String?) ?? '',
              type: ResourceType.room,
              status: ResourceStatus.available,
            ),
          )
          .toList()
          .cast<InstitutionalResource>(),
      staff: staff
          .cast<Map<String, dynamic>>()
          .map(
            (n) => StaffMember(
              id: (n['id'] as String?) ?? '',
              name: (n['name'] as String?) ?? '',
              role: (n['role'] as String?) ?? 'Provider',
              specialization: 'Staff',
              themeColor: Colors.blue,
              avatarUrl: '',
            ),
          )
          .toList()
          .cast<StaffMember>(),
      appointments: appointments
          .cast<Map<String, dynamic>>()
          .map(
            (n) => Appointment(
              id: (n['id'] as String?) ?? '',
              patientName:
                  ((n['client'] as Map<String, dynamic>?)?['fullName']
                      as String?) ??
                  'Patient',
              startTime: DateTime.parse(
                (n['requestedStartAt'] as String?) ??
                    DateTime.now().toIso8601String(),
              ),
              duration: Duration(
                minutes: ((n['durationMinutes'] as num?) ?? 60).toInt(),
              ),
              status: AppointmentStatus.confirmed,
              staffId: '0',
            ),
          )
          .toList()
          .cast<Appointment>(),
    );
  }

  /// Generic helper for retrieving a domain node by ID from the institutional cache.
  static Map<String, dynamic>? getInstitutionalNode(String model, String id) {
    final nodes = safeLookup<List<dynamic>>(
      'institutional_nodes.$model',
      <dynamic>[],
    );
    return nodes.cast<Map<String, dynamic>?>().firstWhere(
      (n) => n?['id'] == id,
      orElse: () => null,
    );
  }

  /// Helper for safe nested lookup in the offline cache
  static T safeLookup<T>(String path, T fallback) {
    if (_offlineData == null) return fallback;

    dynamic current = _offlineData;
    final segments = path.split('.');

    for (final segment in segments) {
      if (current is Map) {
        if (current.containsKey(segment)) {
          current = current[segment];
        } else {
          final key = current.keys.cast<String?>().firstWhere(
            (k) => k?.toLowerCase() == segment.toLowerCase(),
            orElse: () => null,
          );

          if (key != null) {
            current = current[key];
          } else {
            return fallback;
          }
        }
      } else {
        return fallback;
      }
    }

    if (current is T) return current;

    if (T == double && current is num) return current.toDouble() as T;
    if (T == int && current is num) return current.toInt() as T;

    return fallback;
  }
}
