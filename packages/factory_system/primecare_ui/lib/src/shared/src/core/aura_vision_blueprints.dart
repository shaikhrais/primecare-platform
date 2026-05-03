// Layer: 01_INFRASTRUCTURE
import 'aura_vision.dart';

/// Centralized repository of Screen Blueprints for Aura Vision (HDL Mode).
class AuraVisionBlueprints {
  /// Map of blueprints indexed by Role Category.
  static final Map<String, AuraScreenBlueprint> roleBlueprints = {
    'Finance Director': const AuraScreenBlueprint(
      screenId: 'HDL_FINANCE',
      title: 'FISCAL INTELLIGENCE HUB',
      visualCategory: 'Finance',
      mockData: {
        'telemetryValue': r'$4.2M',
        'status': 'Optimized',
        'trend': '+12.5%',
        'kpi': '98% Ledger Sync',
      },
      components: ['AuraDashboardHud', 'FinancialGrid', 'RevenueProjectionModel'],
    ),
    'Clinical Director': const AuraScreenBlueprint(
      screenId: 'HDL_CLINICAL',
      title: 'CLINICAL OUTCOMES COMMAND',
      visualCategory: 'Clinical',
      mockData: {
        'telemetryValue': '94%',
        'status': 'At Standard',
        'trend': 'Improving',
        'kpi': '0.2% Incident Rate',
      },
      components: ['AuraDashboardHud', 'PatientMetricGrid', 'RoboticDispensingInterface'],
    ),
    'Operations Manager': const AuraScreenBlueprint(
      screenId: 'HDL_OPS',
      title: 'OPERATIONAL FLOW RADAR',
      visualCategory: 'Operations',
      mockData: {
        'telemetryValue': '88%',
        'status': 'High Load',
        'trend': 'Sustained',
        'kpi': '12m Avg Response',
      },
      components: ['AuraDashboardHud', 'ResourceHeatmap', 'LiveDispatchMap'],
    ),
    'CTO': const AuraScreenBlueprint(
      screenId: 'HDL_CTO',
      title: 'COMMAND HORIZON: INFRA',
      visualCategory: 'Technical',
      mockData: {
        'telemetryValue': '99.99%',
        'status': 'Operational',
        'trend': 'Nominal',
        'kpi': '45ms Latency',
      },
      components: ['AuraDashboardHud', 'ServerHealthGrid', 'TrafficBurstGraph'],
    ),
    'CEO': const AuraScreenBlueprint(
      screenId: 'HDL_CEO',
      title: 'ENTERPRISE STRATEGY VORTEX',
      visualCategory: 'Executive',
      mockData: {
        'telemetryValue': '100%',
        'status': 'Peak Performance',
        'trend': 'Exponential',
        'kpi': 'P0 Priority Clear',
      },
      components: ['AuraDashboardHud', 'GlobalReachMap', 'ExecutiveSummary'],
    ),
    'Administrator': const AuraScreenBlueprint(
      screenId: 'HDL_ADMIN',
      title: 'SYSTEM OVERWATCH',
      visualCategory: 'System',
      mockData: {
        'telemetryValue': 'Zero Drift',
        'status': 'Secure',
        'trend': 'Stable',
        'kpi': '100% Policy Sync',
      },
      components: ['AuraDashboardHud', 'AuditLogPanel', 'UserAccessGrid'],
    ),
    'Developer': const AuraScreenBlueprint(
      screenId: 'HDL_DEV',
      title: 'ENGINEERING ATELIER',
      visualCategory: 'Technical',
      mockData: {
        'telemetryValue': 'v4.2.0-STABLE',
        'status': 'Build Passed',
        'trend': 'Rapid',
        'kpi': '12m Deploy Cycle',
      },
      components: ['AuraDashboardHud', 'GitStatusStream', 'CodeAnalysisGauge'],
    ),
    'Auditor': const AuraScreenBlueprint(
      screenId: 'HDL_AUDIT',
      title: 'COMPLIANCE RADAR',
      visualCategory: 'Governance',
      mockData: {
        'telemetryValue': '100%',
        'status': 'Verified',
        'trend': 'Absolute',
        'kpi': 'Zero Exceptions',
      },
      components: ['AuraDashboardHud', 'ComplianceChecklist', 'AuditHistory'],
    ),
    'Standard User': const AuraScreenBlueprint(
      screenId: 'HDL_USER',
      title: 'PERSONAL COMMAND CENTER',
      visualCategory: 'General',
      mockData: {
        'telemetryValue': 'Next Shift: 08:00',
        'status': 'Active',
        'trend': 'Steady',
        'kpi': '5 Pending Tasks',
      },
      components: ['AuraDashboardHud', 'PersonalCalendar', 'TaskQueue'],
    ),
    'Psw': const AuraScreenBlueprint(
      screenId: 'HDL_PSW',
      title: 'CARE MOBILITY HUB',
      visualCategory: 'Clinical',
      mockData: {
        'telemetryValue': '4/6 Visits',
        'status': 'On Schedule',
        'trend': 'Efficient',
        'kpi': '100% Documentation',
      },
      components: ['AuraDashboardHud', 'VisitList', 'VitalsInput'],
    ),
    'Rn': const AuraScreenBlueprint(
      screenId: 'HDL_RN',
      title: 'NURSING OVERSIGHT',
      visualCategory: 'Clinical',
      mockData: {
        'telemetryValue': '8 Patients',
        'status': 'Med Pass Active',
        'trend': 'Nominal',
        'kpi': 'Zero Med Errors',
      },
      components: ['AuraDashboardHud', 'ClinicalChart', 'MedicationLog'],
    ),
    'Coordinator': const AuraScreenBlueprint(
      screenId: 'HDL_COORDINATOR',
      title: 'LOGISTICS ORCHESTRATOR',
      visualCategory: 'Operations',
      mockData: {
        'telemetryValue': '12 Unassigned',
        'status': 'Action Required',
        'trend': 'Busy',
        'kpi': '85% Rota Fill',
      },
      components: ['AuraDashboardHud', 'SchedulingGrid', 'ConflictResolver'],
    ),
    'Family': const AuraScreenBlueprint(
      screenId: 'HDL_FAMILY',
      title: 'LOVED ONE CIRCLE',
      visualCategory: 'Family',
      mockData: {
        'telemetryValue': 'Stable',
        'status': 'Resting',
        'trend': 'Steady',
        'kpi': 'Last Visit: 2h ago',
      },
      components: ['AuraDashboardHud', 'TimelineView', 'CareChat'],
    ),
    'Manager': const AuraScreenBlueprint(
      screenId: 'HDL_MANAGER',
      title: 'SECTOR PERFORMANCE',
      visualCategory: 'Management',
      mockData: {
        'telemetryValue': '92%',
        'status': 'Above Target',
        'trend': 'Growth',
        'kpi': '12 New Leads',
      },
      components: ['AuraDashboardHud', 'KpiHeatmap', 'StaffingOverview'],
    ),
  };

  /// Resolves a blueprint for a specific role, falling back to a default if not found.
  static AuraScreenBlueprint resolveForRole(String role) {
    // Normalize role name
    final normalized = role.split('_').map((e) => 
      e.isNotEmpty ? '${e[0].toUpperCase()}${e.substring(1).toLowerCase()}' : ''
    ).join(' ');

    return roleBlueprints[normalized] ?? 
           roleBlueprints['Standard User']!; // Default to Standard User
  }
}
