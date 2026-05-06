import 'package:flutter_core/flutter_core.dart';

/// Programmatic seeding of the Auditor's Blueprints for the PrimeCare Platform.
/// This file defines the "Gold Standard" for every screen in the system.
class BlueprintSeeder {
  static void seed() {
    // --- PSW MODULE SUITE (STITCH COMPLIANT) ---

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/clinical/roles/psw/dashboard',
        description: 'PrimeCare V4: PSW Core Dashboard',
        reasoning: 'Operational hub for Personal Support Workers requiring clinical summaries and incident tracking.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Operational Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Clinical Summary', intent: 'Patient Context', importance: 'high'),
          BlueprintComponent(label: 'Care Plan Checklist', intent: 'Task Compliance', importance: 'critical'),
          BlueprintComponent(label: 'Incident Quick-Report', intent: 'Risk Management', importance: 'high'),
          BlueprintComponent(label: 'Interactive Route Logistics', intent: 'Route Optimization', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/clinical/roles/psw/shift-tracker',
        description: 'PrimeCare V4: PSW Shift Tracking',
        reasoning: 'Verified time and location logging for compliance and payroll.',
        requiredComponents: [
          BlueprintComponent(label: 'Time Clock Widget', intent: 'Clock-In/Out', importance: 'critical'),
          BlueprintComponent(label: 'Visit Log List', intent: 'Operational Logging', importance: 'high'),
          BlueprintComponent(label: 'GPS Validation Feed', intent: 'Compliance Verification', importance: 'high'),
          BlueprintComponent(label: 'Interactive Route Logistics', intent: 'Geofencing Compliance', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/clinical/roles/psw/clients',
        description: 'PrimeCare V4: PSW Client Management',
        reasoning: 'Directory of active patients with care requirements and risk indicators.',
        requiredComponents: [
          BlueprintComponent(label: 'Client Directory Card', intent: 'Patient Identification', importance: 'critical'),
          BlueprintComponent(label: 'Risk Status Indicator', intent: 'Safety Awareness', importance: 'high'),
          BlueprintComponent(label: 'Emergency Contact Hub', intent: 'Crisis Management', importance: 'critical'),
          BlueprintComponent(label: 'Interactive Route Logistics', intent: 'Geofencing Compliance', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/clinical/roles/psw/tasks',
        description: 'PrimeCare V4: PSW Care Plan Tasks',
        reasoning: 'Checklist-driven care plan execution with medication and meal tracking.',
        requiredComponents: [
          BlueprintComponent(label: 'Medication Task Group', intent: 'Medical Compliance', importance: 'critical'),
          BlueprintComponent(label: 'Meal Prep Log', intent: 'ADL Tracking', importance: 'high'),
          BlueprintComponent(label: 'ADL Completion Status', intent: 'Operational Summary', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/clinical/roles/psw/messages',
        description: 'PrimeCare V4: PSW Communications',
        reasoning: 'Secure coordination between field workers and clinical supervisors.',
        requiredComponents: [
          BlueprintComponent(label: 'Clinical Chat Thread', intent: 'Team Coordination', importance: 'critical'),
          BlueprintComponent(label: 'Supervisor Direct Link', intent: 'Clinical Escalation', importance: 'high'),
          BlueprintComponent(label: 'Attachment Manager', intent: 'Evidence Capture', importance: 'low'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/clinical/roles/psw/visit-notes',
        description: 'PrimeCare V4: PSW Visit Documentation',
        reasoning: 'Point-of-care documentation including narrative notes and imaging.',
        requiredComponents: [
          BlueprintComponent(label: 'Narrative Note Editor', intent: 'Clinical Reporting', importance: 'critical'),
          BlueprintComponent(label: 'Wound Imaging Module', intent: 'Clinical Evidence', importance: 'high'),
          BlueprintComponent(label: 'Family Connect Log', intent: 'Stakeholder Communication', importance: 'medium'),
          BlueprintComponent(label: 'Interactive Route Logistics', intent: 'Visit Verification', importance: 'medium'),
        ],
      ),
    );

    // --- RN MODULE SUITE (STITCH COMPLIANT) ---
    
    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/clinical/roles/rn/dashboard',
        description: 'PrimeCare V4: RN Core Dashboard',
        reasoning: 'Clinical oversight hub for Registered Nurses requiring acuity tracking and medication reconciliation.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Clinical Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'MAR Reconciliation', intent: 'Medication Safety', importance: 'critical'),
          BlueprintComponent(label: 'Clinical Acuity Heatmap', intent: 'Risk Prioritization', importance: 'high'),
          BlueprintComponent(label: 'Wound Care Module', intent: 'Treatment Documentation', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/clinical/roles/rn/assessments',
        description: 'PrimeCare V4: RN Assessment Hub',
        reasoning: 'Standardized clinical assessments (OASIS/interRAI) with dynamic scoring.',
        requiredComponents: [
          BlueprintComponent(label: 'Bento Assessment Hub', intent: 'Modular Assessments', importance: 'critical'),
          BlueprintComponent(label: 'Dynamic Scoring Engine', intent: 'Real-time Calculations', importance: 'high'),
          BlueprintComponent(label: 'Validation Summary', intent: 'Compliance Check', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/clinical/roles/rn/care-plans',
        description: 'PrimeCare V4: RN Care Planning',
        reasoning: 'Lifecycle management of patient care plans and multi-disciplinary coordination.',
        requiredComponents: [
          BlueprintComponent(label: 'Care Plan Builder', intent: 'Structured Planning', importance: 'critical'),
          BlueprintComponent(label: 'Intervention Library', intent: 'Standardized Care', importance: 'high'),
          BlueprintComponent(label: 'Goal Status Tracker', intent: 'Outcome Monitoring', importance: 'high'),
        ],
      ),
    );

    // --- COORDINATOR MODULE SUITE (STITCH COMPLIANT) ---

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/operational/roles/coordinator/hub',
        description: 'PrimeCare V4: Coordinator Scheduling Hub',
        reasoning: 'Real-time allocation center for coordinators managing staff schedules and swaps.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Operational Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Scheduling Hub', intent: 'Shift Management', importance: 'critical'),
          BlueprintComponent(label: 'Staff Allocation Matrix', intent: 'Resource Optimization', importance: 'high'),
          BlueprintComponent(label: 'Shift Swap Manager', intent: 'Negotiation Workflow', importance: 'medium'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/operational/roles/coordinator/sos',
        description: 'PrimeCare V4: Coordinator SOS Center',
        reasoning: 'Emergency response triage hub for managing clinical alerts and field crises.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Emergency Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'SOS Alert Monitor', intent: 'Triage Monitoring', importance: 'critical'),
          BlueprintComponent(label: 'Clinical Escalation Link', intent: 'Crisis Support', importance: 'high'),
          BlueprintComponent(label: 'Resolution Tracker', intent: 'Outcome Documentation', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/operational/roles/coordinator/waitlist',
        description: 'PrimeCare V4: Coordinator Waitlist Triage',
        reasoning: 'Referral management and assessment scheduling for new clients.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Growth Telemetry', importance: 'medium'),
          BlueprintComponent(label: 'Waitlist Queue', intent: 'Referral Management', importance: 'critical'),
          BlueprintComponent(label: 'Priority Scoring Engine', intent: 'Triage Accuracy', importance: 'high'),
          BlueprintComponent(label: 'Assessment Status Tracker', intent: 'Clinical Readiness', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/operational/roles/coordinator/dispatch',
        description: 'PrimeCare V4: Live Operational Dispatch Map',
        reasoning: 'Spatial visualization center for fleet monitoring and regional health oversight.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Spatial Telemetry', importance: 'high'),
          BlueprintComponent(label: 'Interactive Route Logistics', intent: 'Fleet Visualization', importance: 'critical'),
          BlueprintComponent(label: 'SOS Alert Overlay', intent: 'Emergency Context', importance: 'critical'),
          BlueprintComponent(label: 'Fleet GPS Heartbeats', intent: 'Live Tracking', importance: 'high'),
        ],
      ),
    );

    // --- ALLIED HEALTH SUITE (STITCH COMPLIANT) ---

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/clinical/roles/rmt/dashboard',
        description: 'PrimeCare V4: RMT Clinical Hub',
        reasoning: 'Specialized therapy dashboard for Registered Massage Therapists.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Clinical Telemetry', importance: 'medium'),
          BlueprintComponent(label: 'Massage Session Log', intent: 'Treatment Documentation', importance: 'critical'),
          BlueprintComponent(label: 'Client Trigger Point Map', intent: 'Anatomical Tracking', importance: 'high'),
          BlueprintComponent(label: 'Therapeutic Goal Tracker', intent: 'Outcome Management', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/clinical/roles/rpn/dashboard',
        description: 'PrimeCare V4: RPN Clinical Hub',
        reasoning: 'Practical nursing dashboard for RPNs managing floor vitals and medication.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Nursing Telemetry', importance: 'high'),
          BlueprintComponent(label: 'Vitals Monitor', intent: 'Patient Safety', importance: 'critical'),
          BlueprintComponent(label: 'Medication Queue', intent: 'Administration', importance: 'critical'),
          BlueprintComponent(label: 'Shift Handover Notes', intent: 'Continuity of Care', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/clinical/roles/chiro/dashboard',
        description: 'PrimeCare V4: Chiropractor Clinical Hub',
        reasoning: 'Structural health dashboard for Chiropractors.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Structural Telemetry', importance: 'medium'),
          BlueprintComponent(label: 'Patient Spine Health Tracker', intent: 'Clinical Baseline', importance: 'critical'),
          BlueprintComponent(label: 'Adjustment Protocol Log', intent: 'Treatment Record', importance: 'high'),
          BlueprintComponent(label: 'Imaging View', intent: 'Diagnostic Support', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/clinical/roles/pt/dashboard',
        description: 'PrimeCare V4: Physiotherapist Clinical Hub',
        reasoning: 'Rehabilitation dashboard for Physiotherapists.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Mobility Telemetry', importance: 'medium'),
          BlueprintComponent(label: 'Mobility Progress Chart', intent: 'Function Tracking', importance: 'critical'),
          BlueprintComponent(label: 'Treatment Session Timer', intent: 'Efficiency', importance: 'low'),
          BlueprintComponent(label: 'Rehab Plan Builder', intent: 'Care Planning', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/clinical/roles/sw/dashboard',
        description: 'PrimeCare V4: Social Work Clinical Hub',
        reasoning: 'Psychosocial support dashboard for Social Workers.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD (Crisis Response Time)', intent: 'Response Metrics', importance: 'high'),
          BlueprintComponent(label: 'Psychosocial Observation Log', intent: 'Clinical Documentation', importance: 'critical'),
          BlueprintComponent(label: 'Resource Mapping Tool', intent: 'External Referrals', importance: 'medium'),
          BlueprintComponent(label: 'Intervention Tracker', intent: 'Outcome Tracking', importance: 'high'),
        ],
      ),
    );

    // --- OTHER CLINICAL MODULES ---

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/clinical-director-dashboard',
        description: 'Clinical Director Dashboard',
        reasoning: 'High-level oversight of clinical safety and compliance.',
        requiredComponents: [
          BlueprintComponent(label: 'Clinical Safety Score', intent: 'Safety Metrics', importance: 'critical'),
          BlueprintComponent(label: 'Staffing Heatmap', intent: 'Resource Optimization', importance: 'high'),
          BlueprintComponent(label: 'Protocol Compliance', intent: 'Quality Assurance', importance: 'critical'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/intake-coordinator-dashboard',
        description: 'Intake Coordinator Dashboard',
        reasoning: 'Central hub for managing new patient referrals and capacity.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD (Total Active Intakes)', intent: 'Volume Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Intake Funnel Chart', intent: 'Process Visibility', importance: 'high'),
          BlueprintComponent(label: 'Urgent Referral List', intent: 'Priority Management', importance: 'critical'),
          BlueprintComponent(label: 'Capacity Availability Grid', intent: 'Resource Planning', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/nurse-dashboard',
        description: 'Nurse Dashboard',
        reasoning: 'Clinical interface for medication management and patient assessment.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD (Critical Alerts)', intent: 'Safety Monitoring', importance: 'critical'),
          BlueprintComponent(label: 'MAR (Medication Record)', intent: 'Medical Compliance', importance: 'critical'),
          BlueprintComponent(label: 'Nurse Assessment Grid', intent: 'Clinical Documentation', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/rn-dashboard',
        description: 'RN Dashboard',
        reasoning: 'Advanced clinical oversight and specialized care modules.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Clinical Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Medication Administration Record', intent: 'Medical Compliance', importance: 'critical'),
          BlueprintComponent(label: 'Wound Care Module', intent: 'Specialized Care', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/therapist-dashboard',
        description: 'Therapist Dashboard',
        reasoning: 'Specialized view for physical and occupational therapy management.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD (Treatment Velocity)', intent: 'Outcome Tracking', importance: 'critical'),
          BlueprintComponent(label: 'Patient Anatomy Map', intent: 'Clinical Visualization', importance: 'high'),
          BlueprintComponent(label: 'SOAP Note Builder', intent: 'Standardized Documentation', importance: 'critical'),
          BlueprintComponent(label: 'Treatment Plan View', intent: 'Care Continuity', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/social-worker-dashboard',
        description: 'Social Worker Dashboard',
        reasoning: 'Interface for managing psychosocial care and community resources.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD (Crisis Response Time)', intent: 'Response Metrics', importance: 'critical'),
          BlueprintComponent(label: 'Psychosocial Observation Log', intent: 'Behavioral Tracking', importance: 'high'),
          BlueprintComponent(label: 'Resource Mapping Tool', intent: 'Community Support', importance: 'medium'),
          BlueprintComponent(label: 'Intervention Tracker', intent: 'Care Outcomes', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/chiropractor-dashboard',
        description: 'Chiropractor Dashboard',
        reasoning: 'Focused view for spinal health and adjustment protocols.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Clinical Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Patient Spine Health Tracker', intent: 'Condition Tracking', importance: 'high'),
          BlueprintComponent(label: 'Adjustment Protocol Log', intent: 'Treatment Compliance', importance: 'critical'),
          BlueprintComponent(label: 'Imaging View', intent: 'Diagnostic Support', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/physiotherapist-dashboard',
        description: 'Physiotherapist Dashboard',
        reasoning: 'Comprehensive view for mobility progress and rehab planning.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Clinical Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Mobility Progress Chart', intent: 'Outcome Visualization', importance: 'high'),
          BlueprintComponent(label: 'Treatment Session Timer', intent: 'Operational Efficiency', importance: 'medium'),
          BlueprintComponent(label: 'Rehab Plan Builder', intent: 'Care Planning', importance: 'critical'),
        ],
      ),
    );

    // --- OPERATIONAL MODULES ---

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/receptionist-dashboard',
        description: 'Receptionist Dashboard',
        reasoning: 'Front-desk operations requiring calendar and check-in management.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Volume Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Appointment Calendar', intent: 'Scheduling', importance: 'critical'),
          BlueprintComponent(label: 'Check-in Queue', intent: 'Process Management', importance: 'high'),
          BlueprintComponent(label: 'Directory Search', intent: 'Information Retrieval', importance: 'medium'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/compliance-hub',
        description: 'Compliance Hub',
        reasoning: 'Regulatory oversight and audit trailing for the platform.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Operational Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Regulatory Alignment Score', intent: 'Compliance Monitoring', importance: 'critical'),
          BlueprintComponent(label: 'Audit Trailing Grid', intent: 'Evidence Tracking', importance: 'high'),
          BlueprintComponent(label: 'Compliance Deadlines', intent: 'Task Management', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/verification-hub',
        description: 'Verification Hub',
        reasoning: 'Identity and credential validation for staff and providers.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Volume Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Identity Verification Queue', intent: 'Process Management', importance: 'critical'),
          BlueprintComponent(label: 'Credential Validation Heatmap', intent: 'Status Visualization', importance: 'high'),
          BlueprintComponent(label: 'Security Checkpoint Logs', intent: 'Audit Tracking', importance: 'medium'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/region-dashboard',
        description: 'Region Dashboard',
        reasoning: 'Regional performance oversight and site management.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Regional Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Regional Performance Comparison', intent: 'Analytics', importance: 'high'),
          BlueprintComponent(label: 'Site Health Overlays', intent: 'Status Monitoring', importance: 'high'),
          BlueprintComponent(label: 'Local Management Controls', intent: 'Operational Control', importance: 'medium'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/support-dashboard',
        description: 'Support Dashboard',
        reasoning: 'System support and ticket management interface.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Ticket Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Ticket Lifecycle Tracker', intent: 'Process Monitoring', importance: 'critical'),
          BlueprintComponent(label: 'SLA Compliance Monitor', intent: 'Performance Tracking', importance: 'high'),
          BlueprintComponent(label: 'Support Knowledge Base', intent: 'Information Retrieval', importance: 'medium'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/dispatch/live',
        description: 'Live Dispatch Map',
        reasoning: 'Real-time geographic tracking for field dispatch.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Dispatch Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Standard View', intent: 'Map Visualization', importance: 'critical'),
        ],
      ),
    );

    // --- BUSINESS DEVELOPMENT MODULES ---

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/territory-expansion-manager-dashboard',
        description: 'Territory Expansion Manager Dashboard',
        reasoning: 'Strategic growth and territory vetting interface.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD (Expansion Roadmap)', intent: 'Growth Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Geographic Vetting Map', intent: 'Spatial Analytics', importance: 'high'),
          BlueprintComponent(label: 'Site Viability Scorecard', intent: 'Decision Support', importance: 'critical'),
          BlueprintComponent(label: 'Research Log', intent: 'Information Logging', importance: 'medium'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/regional-manager-ontario-dashboard',
        description: 'Regional Manager Ontario Dashboard',
        reasoning: 'Ontario-specific revenue and market oversight.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD (Ontario Revenue Growth)', intent: 'Financial Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Regional Revenue Grid', intent: 'Financial Analytics', importance: 'critical'),
          BlueprintComponent(label: 'Ontario Market Heatmap', intent: 'Market Visualization', importance: 'high'),
          BlueprintComponent(label: 'Site Audit Tracker', intent: 'Compliance Monitoring', importance: 'medium'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/regional-manager-usa-dashboard',
        description: 'Regional Manager USA Dashboard',
        reasoning: 'USA expansion velocity and multi-state revenue tracking.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD (US Expansion Velocity)', intent: 'Growth Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Multi-state Revenue Grid', intent: 'Financial Analytics', importance: 'critical'),
          BlueprintComponent(label: 'USA Expansion Map', intent: 'Market Visualization', importance: 'high'),
          BlueprintComponent(label: 'Compliance Drift Log', intent: 'Risk Management', importance: 'medium'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/franchise-sales-manager-dashboard',
        description: 'Franchise Sales Manager Dashboard',
        reasoning: 'Sales funnel and candidate lifecycle management.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD (Franchise Sales Funnel)', intent: 'Sales Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Sales Funnel Visualization', intent: 'Process Visibility', importance: 'high'),
          BlueprintComponent(label: 'Candidate Lifecycle Map', intent: 'Candidate Tracking', importance: 'critical'),
          BlueprintComponent(label: 'CD Pipeline Monitor', intent: 'Process Monitoring', importance: 'medium'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/partnership-manager-dashboard',
        description: 'Partnership Manager Dashboard',
        reasoning: 'Partner synergy and affiliate performance tracking.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD (Partner Synergy Matrix)', intent: 'Synergy Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Partner Referral Grid', intent: 'Financial Analytics', importance: 'high'),
          BlueprintComponent(label: 'Affiliate Performance Table', intent: 'Performance Tracking', importance: 'high'),
          BlueprintComponent(label: 'Synergy DashboardMetrics', intent: 'Outcome Tracking', importance: 'medium'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/general-manager-dashboard',
        description: 'General Manager Dashboard',
        reasoning: 'Occupancy trends and facility revenue oversight.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD (Occupancy Trend)', intent: 'Volume Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Occupancy Heatmap', intent: 'Status Visualization', importance: 'high'),
          BlueprintComponent(label: 'Facility Revenue Grid', intent: 'Financial Analytics', importance: 'critical'),
          BlueprintComponent(label: 'Resource Utilization', intent: 'Efficiency Tracking', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/regional-bdm-dashboard',
        description: 'Regional BDM Dashboard',
        reasoning: 'Territory performance and BDM activity tracking.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Sales Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Territory Performance Heatmap', intent: 'Market Visualization', importance: 'high'),
          BlueprintComponent(label: 'BDM Activity Log', intent: 'Activity Tracking', importance: 'high'),
          BlueprintComponent(label: 'Conversion Statistics', intent: 'Outcome Analytics', importance: 'critical'),
        ],
      ),
    );

    // --- VIRTUAL & GOVERNANCE ROUTES ---

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/admin-settings',
        description: 'Admin Settings',
        reasoning: 'Central configuration and system management.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Operational Metric', importance: 'critical'),
          BlueprintComponent(label: 'Drift Detection', intent: 'Governance Monitoring', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/architecture-governance',
        description: 'Architecture Governance',
        reasoning: 'System-wide parity and integrity monitoring.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Operational Metric', importance: 'critical'),
          BlueprintComponent(label: 'Drift Detection', intent: 'Governance Monitoring', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/logistics-hub',
        description: 'Logistics Hub',
        reasoning: 'Supply chain and operational logistics tracking.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Operational Metric', importance: 'critical'),
          BlueprintComponent(label: 'Drift Detection', intent: 'Governance Monitoring', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/operational/staffing-director',
        description: 'Staffing Director Dashboard',
        reasoning: 'Staffing forecast and shift optimization.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Operational Metric', importance: 'critical'),
          BlueprintComponent(label: 'Staffing Forecast Grid', intent: 'Resource Planning', importance: 'critical'),
          BlueprintComponent(label: 'Shift Optimization Heatmap', intent: 'Efficiency Tracking', importance: 'high'),
          BlueprintComponent(label: 'Credentialing Pipeline', intent: 'Process Monitoring', importance: 'medium'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/operational/regional-manager',
        description: 'Operational Regional Manager Dashboard',
        reasoning: 'Regional KPI and incident aggregator interface.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Regional Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Regional KPI Matrix', intent: 'Analytics', importance: 'high'),
          BlueprintComponent(label: 'Branch Health Scorecard', intent: 'Status Monitoring', importance: 'high'),
          BlueprintComponent(label: 'Incident Aggregator', intent: 'Risk Management', importance: 'medium'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/business-development/regional-view',
        description: 'Business Development Regional View',
        reasoning: 'Territory KPI and site compliance monitoring.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Regional Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Regional Heatmap', intent: 'Market Visualization', importance: 'high'),
          BlueprintComponent(label: 'Site Compliance Grid', intent: 'Compliance Monitoring', importance: 'high'),
          BlueprintComponent(label: 'Territory KPI HUD', intent: 'Performance Tracking', importance: 'medium'),
        ],
      ),
    );
    // --- CORPORATE MODULES ---

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/ceo-dashboard',
        description: 'CEO Dashboard',
        reasoning: 'High-level strategic oversight and global KPI tracking.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Global Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Global KPI DashboardMetrics', intent: 'Strategic Analytics', importance: 'critical'),
          BlueprintComponent(label: 'Region Comparison', intent: 'Market Analysis', importance: 'high'),
          BlueprintComponent(label: 'Strategic Initiatives', intent: 'Project Tracking', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/coo-dashboard',
        description: 'COO Dashboard',
        reasoning: 'Operational oversight and efficiency tracking across branches.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Operational Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Operational KPI Grid', intent: 'Efficiency Analytics', importance: 'critical'),
          BlueprintComponent(label: 'Branch Efficiency Table', intent: 'Site Performance', importance: 'high'),
          BlueprintComponent(label: 'Service Quality Log', intent: 'Quality Assurance', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/cfo-dashboard',
        description: 'CFO Dashboard',
        reasoning: 'Financial oversight, liquidity, and capital allocation.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Financial Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Liquidity Index', intent: 'Risk Assessment', importance: 'critical'),
          BlueprintComponent(label: 'Burn Rate Analysis', intent: 'Financial Monitoring', importance: 'high'),
          BlueprintComponent(label: 'Capital Allocation', intent: 'Resource Management', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/compliance-manager-dashboard',
        description: 'Compliance Manager Dashboard',
        reasoning: 'Registry integrity and anomaly detection for governance.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Operational Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'DashboardRegistry Integrity Score', intent: 'Governance Monitoring', importance: 'critical'),
          BlueprintComponent(label: 'Anomaly Heatmap', intent: 'Risk Detection', importance: 'high'),
          BlueprintComponent(label: 'Execution Gate Logs', intent: 'Process Control', importance: 'medium'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/training-director-dashboard',
        description: 'Training Director Dashboard',
        reasoning: 'Staff certification and competency tracking.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Competency Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Certification Heatmap', intent: 'Status Visualization', importance: 'high'),
          BlueprintComponent(label: 'Active Course Enrollment', intent: 'Process Tracking', importance: 'high'),
          BlueprintComponent(label: 'Competency Drift Alert', intent: 'Risk Management', importance: 'critical'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/finance-director-dashboard',
        description: 'Finance Director Dashboard',
        reasoning: 'Budget distribution and cash flow forecasting.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Financial Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Financial Summary Grid', intent: 'Financial Analytics', importance: 'critical'),
          BlueprintComponent(label: 'Cash Flow Forecast', intent: 'Decision Support', importance: 'high'),
          BlueprintComponent(label: 'Budget Distribution', intent: 'Resource Planning', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/head-of-bus-dev-dashboard',
        description: 'Head of Business Development Dashboard',
        reasoning: 'Pipeline velocity and expansion roadmap oversight.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD (Pipeline Velocity)', intent: 'Growth Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Pipeline Velocity Chart', intent: 'Sales Analytics', importance: 'critical'),
          BlueprintComponent(label: 'Expansion Roadmap Heatmap', intent: 'Market Visualization', importance: 'high'),
          BlueprintComponent(label: 'Partner Synergy Matrix', intent: 'Synergy Tracking', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/head-of-marketing-dashboard',
        description: 'Head of Marketing Dashboard',
        reasoning: 'Campaign performance and brand awareness tracking.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Marketing Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Campaign Heatmap', intent: 'Status Visualization', importance: 'high'),
          BlueprintComponent(label: 'Funnel Grid', intent: 'Process Analytics', importance: 'high'),
          BlueprintComponent(label: 'Brand Awareness', intent: 'Market Perception', importance: 'medium'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/hr-manager-dashboard',
        description: 'HR Manager Dashboard',
        reasoning: 'Staffing velocity and HR action hub oversight.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Operational Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Operational DashboardMetrics', intent: 'HR Analytics', importance: 'critical'),
          BlueprintComponent(label: 'HR Action Hub', intent: 'Process Control', importance: 'high'),
          BlueprintComponent(label: 'Staffing Velocity', intent: 'Resource Planning', importance: 'high'),
          BlueprintComponent(label: 'Compliance Audit', intent: 'Risk Management', importance: 'medium'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/hr-hiring-dashboard',
        description: 'HR Hiring Dashboard',
        reasoning: 'Candidate pipeline and onboarding management.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Recruitment Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Candidate Pipeline', intent: 'Process Tracking', importance: 'critical'),
          BlueprintComponent(label: 'Onboarding Checklist', intent: 'Task Management', importance: 'high'),
          BlueprintComponent(label: 'Recruitment KPI Grid', intent: 'Performance Analytics', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/hr-director-dashboard',
        description: 'HR Director Dashboard',
        reasoning: 'Talent retention and succession planning oversight.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD (Talent Retention)', intent: 'Retention Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Succession Planning', intent: 'Strategic Planning', importance: 'high'),
          BlueprintComponent(label: 'Workforce Diversity', intent: 'Social Impact', importance: 'medium'),
          BlueprintComponent(label: 'Global Compensation', intent: 'Financial Planning', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/cx-director-dashboard',
        description: 'CX Director Dashboard',
        reasoning: 'Customer sentiment and journey drift analysis.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD (Experience Velocity)', intent: 'CX Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Sentiment Scorecard', intent: 'Outcome Tracking', importance: 'high'),
          BlueprintComponent(label: 'Retention Analysis', intent: 'Process Analytics', importance: 'high'),
          BlueprintComponent(label: 'Customer Journey Drift', intent: 'Risk Detection', importance: 'critical'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/it-admin-dashboard',
        description: 'IT Admin Dashboard',
        reasoning: 'System uptime and resource allocation oversight.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD (System Uptime)', intent: 'System Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Resource Allocation', intent: 'Resource Management', importance: 'high'),
          BlueprintComponent(label: 'Maintenance Queue', intent: 'Process Monitoring', importance: 'high'),
          BlueprintComponent(label: 'System Logs', intent: 'Audit Tracking', importance: 'medium'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/shareholder-intelligence-dashboard',
        description: 'Shareholder Intelligence Dashboard',
        reasoning: 'Global header and telemetry table for shareholder oversight.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Financial Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Global Header', intent: 'Brand Consistency', importance: 'medium'),
          BlueprintComponent(label: 'Stage 1: Initial', intent: 'Process Status', importance: 'low'),
          BlueprintComponent(label: 'Stage 2: In Processing', intent: 'Process Status', importance: 'low'),
          BlueprintComponent(label: 'Stage 3: Implemented', intent: 'Process Status', importance: 'low'),
          BlueprintComponent(label: 'Stage 4: Tested & Done', intent: 'Process Status', importance: 'low'),
          BlueprintComponent(label: 'Telemetry Table', intent: 'Data Visualization', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/corporate-governance-dashboard',
        description: 'Corporate Governance Dashboard',
        reasoning: 'Subsystem parity and autonomous remediation oversight.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Governance Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Subsystem Parity Matrix', intent: 'Integrity Monitoring', importance: 'critical'),
          BlueprintComponent(label: 'Autonomous Remediation HUD', intent: 'Remediation Control', importance: 'high'),
          BlueprintComponent(label: 'Audit Lifecycle Monitor', intent: 'Process Tracking', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/cto-dashboard',
        description: 'CTO Dashboard',
        reasoning: 'Cloudflare health and CI/CD velocity oversight.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'System Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Cloudflare Stack Health', intent: 'Infrastructure Monitoring', importance: 'critical'),
          BlueprintComponent(label: 'API Gateway Performance', intent: 'Performance Analytics', importance: 'high'),
          BlueprintComponent(label: 'CI/CD Pipeline Velocity', intent: 'Process Monitoring', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/owner-dashboard',
        description: 'Owner Dashboard',
        reasoning: 'Portfolio yield and strategic risk oversight.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Financial Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Portfolio Yield', intent: 'Outcome Tracking', importance: 'critical'),
          BlueprintComponent(label: 'Equity Growth Heatmap', intent: 'Market Visualization', importance: 'high'),
          BlueprintComponent(label: 'Strategic Risk Matrix', intent: 'Risk Management', importance: 'high'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/finance-ledger',
        description: 'Finance Ledger Dashboard',
        reasoning: 'Double-entry balance sheet and journal entry grid oversight.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Financial Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Double-Entry Balance Sheet', intent: 'Financial Analytics', importance: 'critical'),
          BlueprintComponent(label: 'Journal Entry Grid', intent: 'Data Entry', importance: 'critical'),
          BlueprintComponent(label: 'Cash Flow Forecast', intent: 'Decision Support', importance: 'high'),
        ],
      ),
    );

    // --- CEO/CFO/COO/CTO SPECIFIC ROUTES ---

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/corporate/roles/ceo/enterprise-overview',
        description: 'Enterprise Overview',
        reasoning: 'CEO-specific enterprise-wide status view.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Global Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Standard View', intent: 'General Visualization', importance: 'medium'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/corporate/roles/ceo/strategic-kpis',
        description: 'Strategic KPIs',
        reasoning: 'CEO-specific strategic KPI monitoring.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Global Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Standard View', intent: 'General Visualization', importance: 'medium'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/corporate/roles/cfo/financial-overview',
        description: 'Financial Overview',
        reasoning: 'CFO-specific financial status view.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Financial Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Standard View', intent: 'General Visualization', importance: 'medium'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/corporate/roles/coo/operations-overview',
        description: 'Operations Board',
        reasoning: 'COO-specific operations board.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'Operational Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Standard View', intent: 'General Visualization', importance: 'medium'),
        ],
      ),
    );

    BlueprintRegistry.register(
      const AuditorBlueprint(
        route: '/offices/corporate/roles/cto/system-health',
        description: 'System Health',
        reasoning: 'CTO-specific system health monitoring.',
        requiredComponents: [
          BlueprintComponent(label: 'Aura HUD', intent: 'System Telemetry', importance: 'critical'),
          BlueprintComponent(label: 'Standard View', intent: 'General Visualization', importance: 'medium'),
        ],
      ),
    );
  }
}
