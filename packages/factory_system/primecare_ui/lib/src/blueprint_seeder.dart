import 'package:flutter_core/flutter_core.dart';

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
            label: 'DashboardRegistry Integrity Score',
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
            label: 'Global KPI DashboardMetrics',
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
        route: '/offices/corporate/roles/hr_hiring/dashboard',
        description: 'HR and recruitment lifecycle management.',
        reasoning: 'Focused on talent acquisition and onboarding velocity.',
        requiredComponents: [
          BlueprintComponent(
            label: 'Aura HUD',
            intent: 'telemetry',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Candidate Pipeline',
            intent: 'recruitment',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Onboarding Checklist',
            intent: 'compliance',
            importance: 'high',
          ),
          BlueprintComponent(
            label: 'Recruitment KPI Grid',
            intent: 'performance',
            importance: 'high',
          ),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/roles/hr_hiring/dashboard',
        description: 'Office-level HR and recruitment lifecycle management.',
        reasoning: 'Focused on local talent acquisition and onboarding.',
        requiredComponents: [
          BlueprintComponent(
            label: 'Aura HUD',
            intent: 'telemetry',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Candidate Pipeline',
            intent: 'recruitment',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Onboarding Checklist',
            intent: 'compliance',
            importance: 'high',
          ),
          BlueprintComponent(
            label: 'Recruitment KPI Grid',
            intent: 'performance',
            importance: 'high',
          ),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/corporate/roles/head_of_marketing/dashboard',
        description: 'Marketing performance and brand awareness oversight.',
        reasoning:
            'Focuses on ROI and market penetration. Requires real-time campaign tracking.',
        requiredComponents: [
          BlueprintComponent(
            label: 'Aura HUD',
            intent: 'telemetry',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Campaign Heatmap',
            intent: 'performance',
            importance: 'high',
          ),
          BlueprintComponent(
            label: 'Funnel Grid',
            intent: 'conversion',
            importance: 'high',
          ),
          BlueprintComponent(
            label: 'Brand Awareness',
            intent: 'market_presence',
            importance: 'medium',
          ),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/roles/receptionist/dashboard',
        description: 'Front-desk operations and patient flow management.',
        reasoning:
            'Optimized for high-throughput interaction. Ensures no patient is left waiting in the check-in queue.',
        requiredComponents: [
          BlueprintComponent(
            label: 'Aura HUD',
            intent: 'telemetry',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Appointment Calendar',
            intent: 'scheduling',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Check-in Queue',
            intent: 'patient_flow',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Directory Search',
            intent: 'lookup',
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
            label: 'DashboardRegistry Audit Report',
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
    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/corporate/roles/coo/dashboard',
        description: 'Operations Command Center for platform efficiency tracking.',
        reasoning: 'Prioritizes operational telemetry and service quality logs for cross-branch oversight.',
        requiredComponents: [
          BlueprintComponent(
            label: 'Aura HUD',
            intent: 'operational_telemetry',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Operational KPI Grid',
            intent: 'performance_metrics',
            importance: 'high',
          ),
          BlueprintComponent(
            label: 'Branch Efficiency Table',
            intent: 'resource_utilization',
            importance: 'high',
          ),
          BlueprintComponent(
            label: 'Service Quality Log',
            intent: 'risk_mitigation',
            importance: 'medium',
          ),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/clinical/roles/quality_metrics/dashboard',
        description: 'Clinical Governance Engine for outcome tracking and best-practice auditing.',
        reasoning: 'Designed for safety and compliance. Layout prioritizes outcome variance visualization.',
        requiredComponents: [
          BlueprintComponent(
            label: 'Aura HUD',
            intent: 'clinical_vitals',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Outcome Variance Chart',
            intent: 'quality_control',
            importance: 'high',
          ),
          BlueprintComponent(
            label: 'Sentinel Event Log',
            intent: 'risk_mitigation',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Best-Practice Audit',
            intent: 'governance',
            importance: 'high',
          ),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: 'DYNAMIC_ROLE_DASHBOARD',
        description: 'Generic template for dynamic role-based dashboards.',
        reasoning:
            'Provides a fallback structural contract for roles that are being dynamically hydrated without a specialized blueprint.',
        requiredComponents: [
          BlueprintComponent(
            label: 'Aura HUD',
            intent: 'clinical_vitals',
            importance: 'critical',
          ),
          BlueprintComponent(
            label: 'Dynamic Content',
            intent: 'placeholder',
            importance: 'high',
          ),
        ],
      ),
    );

    // --- OPERATIONAL GOVERNANCE ---
    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/operational/staffing-director',
        description: 'Human Capital Hub: Workforce telemetry and staffing optimization.',
        reasoning: 'Prioritizes shift optimization and credentialing pipeline for operational resilience.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Staffing Forecast Grid', intent: 'optimization', importance: 'high'),
          BlueprintComponent(label: 'Shift Optimization Heatmap', intent: 'optimization', importance: 'high'),
          BlueprintComponent(label: 'Credentialing Pipeline', intent: 'compliance', importance: 'critical'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/operational/regional-manager',
        description: 'Territory Oversight: Regional performance and branch health scorecard.',
        reasoning: 'Focuses on aggregated branch health and incident management across territories.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Regional KPI Matrix', intent: 'performance', importance: 'high'),
          BlueprintComponent(label: 'Branch Health Scorecard', intent: 'governance', importance: 'high'),
          BlueprintComponent(label: 'Incident Aggregator', intent: 'risk_mitigation', importance: 'critical'),
        ],
      ),
    );

    // --- BUSINESS DEVELOPMENT GOVERNANCE ---
    final List<String> regions = ['ontario', 'usa', 'quebec', 'bc', 'alberta', 'maritimes'];
    final List<String> domains = ['finance', 'clinical', 'operations', 'hr', 'marketing', 'compliance'];

    for (final region in regions) {
      for (final domain in domains) {
        // Handle the special case for USA HR which has a different key/path pattern sometimes, 
        // but looking at BusinessDevelopmentRegistry, they are consistent.
        // Wait, line 127 in BusinessDevelopmentRegistry had 'usahr' instead of 'usa-hr' in the LocaleKey, 
        // but the route was '/business-development/usa-hr-regional-view'.
        
        String pathDomain = domain;
        if (region == 'usa' && domain == 'hr') {
           // Ensure it matches the registry
        }

        BlueprintRegistry.register(
          AuditorBlueprint(
            route: '/business-development/$region-$pathDomain-regional-view',
            description: 'Regional Oversight: Geo-fenced $domain telemetry for the $region territory.',
            reasoning: 'Standardized regional audit surface for Business Development expansion tracking.',
            requiredComponents: const [
              BlueprintComponent(label: 'Aura HUD', intent: 'telemetry', importance: 'critical'),
              BlueprintComponent(label: 'Regional Heatmap', intent: 'geographic_intelligence', importance: 'high'),
              BlueprintComponent(label: 'Site Compliance Grid', intent: 'governance', importance: 'high'),
              BlueprintComponent(label: 'Territory KPI HUD', intent: 'performance', importance: 'critical'),
            ],
          ),
        );
      }
    }
  }
}
