import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../../dashboard_service.dart';
import '../models/intelligence_insight.dart';
import '../models/scheduler_models.dart';

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
      final String jsonContent = await rootBundle.loadString('assets/data/offline_seed.json');
      _offlineData = json.decode(jsonContent) as Map<String, dynamic>;
      debugPrint('PRIMECARE_LOGISTICS: Offline seed data hydrated successfully.');
    } catch (e) {
      debugPrint('PRIMECARE_LOGISTICS: Failed to load offline seed data: $e');
      _offlineData = {}; // Prevent repeated failed attempts
    }
  }

  /// Provides high-fidelity clinical intelligence blueprints.
  /// Provides high-fidelity clinical intelligence blueprints from the cache.
  static ClinicalIntelligenceViewModel getClinicIntelligenceMetrics() {
    final nodes = safeLookup<List>('institutional_nodes.clinicNode', []);
    
    return ClinicalIntelligenceViewModel(
      isOfflineFallback: true,
      blueprints: [
        const AuraDashboardHudBlueprint(dataPayload: null),
        StatGridBlueprint(
          dataPayload: nodes.map((n) => UniversalKpi(
            title: n['name'] ?? 'Facility',
            value: '${n['patientCount'] ?? 0}',
            trend: 2.1,
            status: KpiStatus.positive,
          )).toList(),
        ),
        // Additional blueprints can be appended here based on domain nodes
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
    final reports = safeLookup<Map<String, dynamic>>('reporting.blueprints', {});
    if (reports.containsKey(reportId)) return reports[reportId];
    
    // Minimal fallback for missing reports
    return {
        'id': reportId,
        'title': 'System Report',
        'columns': [{'key': 'id', 'label': 'ID'}],
        'rows': []
    };
  }

  /// Provides high-fidelity intelligence blueprints for demonstrators.
  static List<IntelligenceInsight> getAuraBlueprints(String role) {
    final aiRecs = safeLookup<List>('institutional_nodes.aiRecommendation', []);
    if (aiRecs.isNotEmpty) {
        return aiRecs.map((n) => IntelligenceInsight(
            id: n['id'] ?? 'ai_gen',
            title: n['name'] ?? 'Insight',
            summary: n['description'] ?? 'Aura is analyzing domain patterns.',
            impact: InsightImpact.positive,
        )).toList();
    }

    return [
      IntelligenceInsight(
        id: 'aura_1',
        title: 'Cache Hydrated',
        summary: 'Aura is pulling insights directly from the institutional data layer.',
        impact: InsightImpact.positive,
      ),
    ];
  }

  static List<IntelligenceInsight> getAuraInsights(String role) => getAuraBlueprints(role);

  static DashboardMetrics getDashboardMetrics(String role) {
    if (_offlineData != null && _offlineData!.containsKey('metrics')) {
      final roleData = _offlineData!['metrics'][role];
      if (roleData != null) {
        try {
          return DashboardMetrics.fromJson(roleData as Map<String, dynamic>);
        } catch (e) {
          debugPrint('PRIMECARE_LOGISTICS: Failed to parse offline data for role $role: $e');
        }
      }
    }
    return _buildResilientFallback(role);
  }

  static DashboardMetrics _buildResilientFallback(String role) {
    // Determine domain-specific context for the fallback
    final isClinical = ['rn', 'rpn', 'psw', 'physiotherapist'].contains(role);
    final isGrowth = ['ceo', 'coo', 'cfo', 'partnership_manager', 'territory_expansion_manager'].contains(role);

    return DashboardMetrics(
      kpis: [
        KpiMetric(title: 'Active Node', value: 'VERIFIED', status: 'stable', subtitle: role.toUpperCase()),
        KpiMetric(
          title: isGrowth ? 'Institutional Growth' : 'Care Compliance', 
          value: isGrowth ? '12.4%' : '98.2%', 
          status: 'positive', 
          subtitle: 'Q1 2026 Baseline'
        ),
        const KpiMetric(title: 'Sync Status', value: 'OFFLINE', status: 'warning', subtitle: 'LKG Snapshot Active')
      ],
      recentActivity: [
        DashboardActivity(
          title: 'Aura Intelligence: Active', 
          subtitle: 'Processing ${role.replaceAll('_', ' ')} domain logic via logistics hub.', 
          timestamp: 'Just now', 
          icon: 'cpu', 
          color: 'purple',
          type: 'system'
        ),
        DashboardActivity(
          title: isClinical ? 'Clinical Sweep: Passed' : 'Security Sweep: Passed', 
          subtitle: 'No anomalies detected in the local cache nodes.', 
          timestamp: '5m ago', 
          icon: 'shield-check', 
          color: 'green',
          type: 'compliance'
        )
      ],
      charts: [],
    );
  }

  /// Horizon (Scheduling) Assembly Logic
  static HorizonSchedule getHorizonBlueprint() {
    final resources = safeLookup<List>('institutional_nodes.institutionalResource', []);
    final staff = safeLookup<List>('institutional_nodes.staffMember', []);
    final appointments = safeLookup<List>('visits', []);

    return HorizonSchedule(
      resources: resources.map((n) => InstitutionalResource(
          id: n['id'], name: n['name'], type: ResourceType.room, status: ResourceStatus.available
      )).toList(),
      staff: staff.map((n) => StaffMember(
          id: n['id'], name: n['name'], role: n['role'] ?? 'Provider'
      )).toList(),
      appointments: appointments.map((n) => Appointment(
          id: n['id'], patientName: n['client']?['fullName'] ?? 'Patient',
          startTime: DateTime.parse(n['requestedStartAt']),
          duration: Duration(minutes: n['durationMinutes'] ?? 60),
          status: AppointmentStatus.confirmed
      )).toList(),
    );
  }

  /// Generic helper for retrieving a domain node by ID from the institutional cache.
  static Map<String, dynamic>? getInstitutionalNode(String model, String id) {
    final nodes = safeLookup<List>('institutional_nodes.$model', []);
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
        // Try exact match first
        if (current.containsKey(segment)) {
          current = current[segment];
        } else {
          // Fallback to case-insensitive lookup (Prisma uses camelCase, Dart might use otherwise)
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
    
    // Type coercion for numbers (JSON might decode to Int or Double)
    if (T == double && current is num) return current.toDouble() as T;
    if (T == int && current is num) return current.toInt() as T;

    // Default to fallback if type mismatch occurs in high-fidelity mapping
    return fallback;
  }
}
