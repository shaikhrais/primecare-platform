// Layer: 02_MODELS_FOUNDATION
import 'dashboard_models.dart';

/// A universal blueprint that defines a UI component mapping from data to layout.
abstract class UIComponentBlueprint {
  /// The type of UI component (e.g. 'stat_card_grid', 'data_table').
  final String componentType;

  /// The abstract payload of data.
  final dynamic dataPayload;

  const UIComponentBlueprint({required this.componentType, this.dataPayload});

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
      case 'ai_forecasting':
        return AIForecastingBlueprint(dataPayload: payload);
      case 'stitch_screen':
        return StitchBlueprint(screenId: payload as String);
      case 'high_fidelity_dashboard':
        return HighFidelityScreenBlueprint(viewId: payload as String);
      case 'data_table':
        return DataTableBlueprint(dataPayload: payload);
      case 'risk_monitor':
        return RiskMonitorBlueprint(dataPayload: payload);
      case 'aura_dashboard_hud':
        return AuraDashboardHudBlueprint(dataPayload: payload);
      case 'management_action':
        return ManagementActionBlueprint(dataPayload: payload);
      case 'clinical_metric':
        return ClinicalMetricBlueprint(dataPayload: payload);
      case 'compliance_gate':
        return ComplianceGateBlueprint(dataPayload: payload);
      case 'certification_expiry_table':
        return CertificationExpiryTableBlueprint(dataPayload: payload);
      case 'staff_competency_map':
        return StaffCompetencyMapBlueprint(dataPayload: payload);
      default:
        return StatGridBlueprint(dataPayload: payload);
    }
  }
}

/// A blueprint for a table showing certification expiry dates.
class CertificationExpiryTableBlueprint extends UIComponentBlueprint {
  const CertificationExpiryTableBlueprint({required super.dataPayload})
    : super(componentType: 'certification_expiry_table');
}

/// A blueprint for a heat map or grid showing staff competencies.
class StaffCompetencyMapBlueprint extends UIComponentBlueprint {
  const StaffCompetencyMapBlueprint({required super.dataPayload})
    : super(componentType: 'staff_competency_map');
}

/// A blueprint for a high-fidelity dashboard pre-built in the ComponentWarehouse.
class HighFidelityScreenBlueprint extends UIComponentBlueprint {
  const HighFidelityScreenBlueprint({required String viewId})
    : super(componentType: 'high_fidelity_dashboard', dataPayload: viewId);

  String get viewId => dataPayload as String;
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

/// A blueprint for AI Analytics Forecasting projections and KPIs.
class AIForecastingBlueprint extends UIComponentBlueprint {
  const AIForecastingBlueprint({required super.dataPayload})
    : super(componentType: 'ai_forecasting');
}
