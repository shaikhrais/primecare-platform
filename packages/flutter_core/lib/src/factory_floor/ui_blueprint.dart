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
  const FinancialRailBlueprint({required super.dataPayload})
    : super(componentType: 'financial_rail');
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

/// A blueprint for Compliance Gatekeeping and Verification (OCR).
class ComplianceGateBlueprint extends UIComponentBlueprint {
  const ComplianceGateBlueprint({required super.dataPayload})
    : super(componentType: 'compliance_gate');
}
