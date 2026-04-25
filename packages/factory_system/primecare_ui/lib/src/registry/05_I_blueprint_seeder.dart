import 'package:flutter_core/00_B_flutter_core.dart';

class BlueprintSeeder {
  static void seed() {
    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/clinical/roles/psw/dashboard',
        description:
            'The primary operational surface for Personal Support Workers during a live clinical visit.',
        reasoning:
            'Optimized for high-stress environments. Prioritizes the Aura HUD for real-time vitals and the Clinical Summary for immediate context.',
        requiredComponents: [
          BlueprintComponent(
            label: 'Aura HUD',
            intent: 'clinical_vitals',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Clinical Summary',
            intent: 'patient_context',
            importance: 'high',
          ),
          BlueprintComponent(
            label: 'Care Plan Checklist',
            intent: 'visit_execution',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Incident Quick-Report',
            intent: 'risk_mitigation',
            importance: 'high',
          ),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/clinical/roles/rmt/dashboard',
        description:
            'Specialized clinical surface for Registered Massage Therapists.',
        reasoning:
            'Focuses on musculoskeletal assessment and session progress tracking.',
        requiredComponents: [
          BlueprintComponent(
            label: 'Aura HUD',
            intent: 'clinical_vitals',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Musculoskeletal Chart',
            intent: 'clinical_diagram',
            importance: 'high',
          ),
          BlueprintComponent(
            label: 'Treatment Plan',
            intent: 'visit_execution',
            importance: 'critical',
          ),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/clinical/roles/rn/dashboard',
        description: 'High-acuity clinical surface for Registered Nurses.',
        reasoning:
            'Prioritizes medication management and advanced clinical assessments.',
        requiredComponents: [
          BlueprintComponent(
            label: 'Aura HUD',
            intent: 'clinical_vitals',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Medication Administration Record',
            intent: 'clinical_safety',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Wound Care Module',
            intent: 'specialized_care',
            importance: 'high',
          ),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/corporate/roles/billing_admin/dashboard',
        description:
            'Central command for revenue cycle management and billing administration.',
        reasoning:
            'Focused on financial throughput. Highlights discrepancies and pending invoices to minimize aging accounts.',
        requiredComponents: [
          BlueprintComponent(
            label: 'Aging Accounts Grid',
            intent: 'financial_health',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Pending Claims Queue',
            intent: 'revenue_ops',
            importance: 'high',
          ),
          BlueprintComponent(
            label: 'Remittance Breakdown',
            intent: 'cash_flow',
            importance: 'medium',
          ),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/corporate/roles/compliance_manager/dashboard',
        description: 'Regulatory oversight and platform integrity dashboard.',
        reasoning:
            'Designed for auditability. Surface-level indicators of platform health coupled with deep-dive anomaly reports.',
        requiredComponents: [
          BlueprintComponent(
            label: 'Registry Integrity Score',
            intent: 'governance_audit',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Anomaly Heatmap',
            intent: 'risk_assessment',
            importance: 'high',
          ),
          BlueprintComponent(
            label: 'Execution Gate Logs',
            intent: 'telemetry_oversight',
            importance: 'medium',
          ),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/corporate/roles/ceo/dashboard',
        description: 'Executive vision and high-level platform performance.',
        reasoning:
            'Aggregates multi-tenant data into actionable KPIs. Minimalistic design to focus on trajectory rather than granular transactions.',
        requiredComponents: [
          BlueprintComponent(
            label: 'Global KPI Metrics',
            intent: 'strategic_vision',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Region Comparison',
            intent: 'market_intelligence',
            importance: 'high',
          ),
          BlueprintComponent(
            label: 'Strategic Initiatives',
            intent: 'platform_governance',
            importance: 'high',
          ),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/corporate/roles/cto/dashboard',
        description: 'The Command Horizon for technical leadership.',
        reasoning:
            'Focuses on infrastructure resilience and architectural integrity.',
        requiredComponents: [
          BlueprintComponent(
            label: 'Command Horizon Header',
            intent: 'cto_dashboard',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Briefing Panel',
            intent: 'cto_dashboard',
            importance: 'high',
          ),
          BlueprintComponent(
            label: 'System Health Cards',
            intent: 'cto_dashboard',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Security Audit Log',
            intent: 'cto_dashboard',
            importance: 'high',
          ),
          BlueprintComponent(
            label: 'Architectural Load',
            intent: 'cto_dashboard',
            importance: 'high',
          ),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/corporate/roles/cfo/dashboard',
        description: 'Strategic financial oversight and capital management.',
        reasoning:
            'Focuses on liquidity and risk. Surface-level visibility into corporate-wide financial health.',
        requiredComponents: [
          BlueprintComponent(
            label: 'Liquidity Index',
            intent: 'financial_health',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Burn Rate Analysis',
            intent: 'risk_management',
            importance: 'high',
          ),
          BlueprintComponent(
            label: 'Capital Allocation',
            intent: 'strategic_planning',
            importance: 'medium',
          ),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/corporate/roles/finance_director/dashboard',
        description: 'Operational financial control and budget management.',
        reasoning:
            'Prioritizes accuracy and control. Ensures all financial summary grids and cash flow forecasts are present for daily operations.',
        requiredComponents: [
          BlueprintComponent(
            label: 'Aura HUD',
            intent: 'operational_telemetry',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Financial Summary Grid',
            intent: 'accounting_ops',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Cash Flow Forecast',
            intent: 'liquidity_ops',
            importance: 'high',
          ),
          BlueprintComponent(
            label: 'Budget Distribution',
            intent: 'resource_allocation',
            importance: 'medium',
          ),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/corporate/roles/training_director/dashboard',
        description:
            'Platform-wide educational oversight and certification control.',
        reasoning:
            'Focused on workforce readiness. Ensures that clinical competencies are tracked and verified.',
        requiredComponents: [
          BlueprintComponent(
            label: 'Certification Heatmap',
            intent: 'training_readiness',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Active Course Enrollment',
            intent: 'educational_ops',
            importance: 'high',
          ),
          BlueprintComponent(
            label: 'Competency Drift Alert',
            intent: 'quality_control',
            importance: 'critical',
          ),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/clinical/roles/clinical_director/dashboard',
        description: 'Clinical governance and patient safety oversight.',
        reasoning:
            'Designed for safety and compliance. Highlights clinical anomalies and staffing gaps across all regions.',
        requiredComponents: [
          BlueprintComponent(
            label: 'Clinical Safety Score',
            intent: 'patient_safety',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Staffing Heatmap',
            intent: 'resource_optimization',
            importance: 'high',
          ),
          BlueprintComponent(
            label: 'Protocol Compliance',
            intent: 'governance',
            importance: 'high',
          ),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/infrastructure/governance/monitor',
        description: 'The definitive platform audit surface.',
        reasoning:
            'Provides a programmatic view of registry alignment and blueprint compliance. Bypasses the generic engine for integrity.',
        requiredComponents: [
          BlueprintComponent(
            label: 'Audit Header',
            intent: 'governance_compliance_dashboard',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Compliance Summary',
            intent: 'governance_compliance_dashboard',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Registry Audit Report',
            intent: 'governance_compliance_dashboard',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Remediation Actions',
            intent: 'governance_compliance_dashboard',
            importance: 'high',
          ),
        ],
      ),
    );
  }
}
