import '../../dashboard_service.dart';

/// A universal blueprint that defines a UI component mapping from data to layout.
abstract class UIComponentBlueprint {
  /// The type of UI component (e.g. 'stat_card_grid', 'data_table').
  final String componentType;

  /// The abstract payload of data.
  final dynamic dataPayload;

  const UIComponentBlueprint({
    required this.componentType,
    required this.dataPayload,
  });

  Map<String, dynamic> toJson() {
    return {
      'componentType': componentType,
      'dataPayload': _payloadToJson(dataPayload),
    };
  }

  static dynamic _payloadToJson(dynamic payload) {
    if (payload is List) {
      return payload.map((e) => _payloadToJson(e)).toList();
    }
    if (payload is Map) {
      return payload.map((k, v) => MapEntry(k, _payloadToJson(v)));
    }
    try {
      // Check if it has a toJson method (e.g. UniversalKpi, DashboardActivity)
      return (payload as dynamic).toJson();
    } catch (_) {
      return payload;
    }
  }

  factory UIComponentBlueprint.fromJson(Map<String, dynamic> json) {
    final type = json['componentType'] as String;
    final payload = json['dataPayload'];

    switch (type) {
      case 'stat_card_grid':
        final list = (payload as List<dynamic>?) ?? [];
        return StatGridBlueprint(
          dataPayload: list.map((i) {
            if (i is Map<String, dynamic>) {
              return UniversalKpi.fromJson(i);
            }
            return i; // Already a UniversalKpi or mixed object
          }).toList(),
        );
      case 'activity_feed':
        final list = (payload as List<dynamic>?) ?? [];
        return ActivityFeedBlueprint(
          dataPayload: list.map((i) {
            if (i is Map<String, dynamic>) {
              return DashboardActivity.fromJson(i);
            }
            return i; // Already an object (e.g. from in-memory assembly)
          }).toList(),
        );
      case 'financial_rail':
        return FinancialRailBlueprint(dataPayload: payload as List<dynamic>);
      case 'analytics_chart':
        return ChartBlueprint(dataPayload: payload);
      case 'stitch_screen':
        return StitchBlueprint(screenId: payload as String);
      default:
        return StatGridBlueprint(dataPayload: payload);
    }
  }
}

/// A blueprint for a Stitch-orchestrated screen.
class StitchBlueprint extends UIComponentBlueprint {
  const StitchBlueprint({required String screenId})
    : super(componentType: 'stitch_screen', dataPayload: screenId);

  String get screenId => dataPayload as String;
}

/// A blueprint for a grid of KPI/stat cards.
class StatGridBlueprint extends UIComponentBlueprint {
  const StatGridBlueprint({required super.dataPayload})
    : super(componentType: 'stat_card_grid');
}

/// A standard KPI data structure for orchestration.
class UniversalKpi {
  final String title;
  final String value;
  final double trend;
  final KpiStatus status;

  const UniversalKpi({
    required this.title,
    required this.value,
    this.trend = 0.0,
    this.status = KpiStatus.neutral,
  });

  static KpiStatus mapStatus(String? status) {
    if (status == null) return KpiStatus.neutral;
    switch (status.toLowerCase()) {
      case 'positive':
      case 'success':
      case 'up':
        return KpiStatus.positive;
      case 'negative':
      case 'error':
      case 'down':
        return KpiStatus.negative;
      case 'warning':
        return KpiStatus.warning;
      case 'critical':
        return KpiStatus.critical;
      default:
        return KpiStatus.neutral;
    }
  }

  factory UniversalKpi.fromJson(Map<String, dynamic> json) {
    return UniversalKpi(
      title: json['title'] as String? ?? 'Unnamed Metric',
      value: json['value'] as String? ?? '0',
      trend: (json['trend'] as num?)?.toDouble() ?? 0.0,
      status: mapStatus(json['status'] as String?),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'value': value,
      'trend': trend,
      'status': status.name,
    };
  }
}

enum KpiStatus { positive, negative, neutral, warning, critical }

/// A blueprint for a live operations feed / recent activity.
class ActivityFeedBlueprint extends UIComponentBlueprint {
  const ActivityFeedBlueprint({required super.dataPayload})
    : super(componentType: 'activity_feed');
}

/// A blueprint for a common layout table.
class DataTableBlueprint extends UIComponentBlueprint {
  const DataTableBlueprint({required super.dataPayload})
    : super(componentType: 'data_table');
}

/// A blueprint for Risk Surveillance monitoring.
class RiskMonitorBlueprint extends UIComponentBlueprint {
  const RiskMonitorBlueprint({required super.dataPayload})
    : super(componentType: 'risk_monitor');
}

/// A blueprint for Financial Rails / Ledger tracking.
class FinancialRailBlueprint extends UIComponentBlueprint {
  const FinancialRailBlueprint({required List<dynamic> super.dataPayload})
    : super(componentType: 'financial_rail');
}

/// A blueprint for the Aura real-time intelligence HUD.
class AuraDashboardHudBlueprint extends UIComponentBlueprint {
  const AuraDashboardHudBlueprint({super.dataPayload})
    : super(componentType: 'aura_dashboard_hud');
}

/// A blueprint for system-level Management Actions (e.g. Quarantine).
class ManagementActionBlueprint extends UIComponentBlueprint {
  const ManagementActionBlueprint({required super.dataPayload})
    : super(componentType: 'management_action');
}

/// A blueprint for Clinical Metrics and ADL oversight.
class ClinicalMetricBlueprint extends UIComponentBlueprint {
  const ClinicalMetricBlueprint({required super.dataPayload})
    : super(componentType: 'clinical_metric');
}

/// A blueprint for high-fidelity Analytics Charts (Line, Bar, Pie).
class ChartBlueprint extends UIComponentBlueprint {
  const ChartBlueprint({required super.dataPayload})
    : super(componentType: 'analytics_chart');
}

/// A blueprint for Compliance Gatekeeping and Verification (OCR).
class ComplianceGateBlueprint extends UIComponentBlueprint {
  const ComplianceGateBlueprint({required super.dataPayload})
    : super(componentType: 'compliance_gate');
}
