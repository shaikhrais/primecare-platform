// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';
import 'base_office_registry.dart';

class ClinicalRegistry extends OfficeScreenRegistry {
  @override
  void bootstrap() {
    registerRoute(
      ClinicalRoutes.clinicalDirectorDashboard,
      PrimeCareForm.clinicalDirectorDashboard,
      provider: clinicalDirectorDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Clinical Safety Score)',
        'Staffing Heatmap',
        'Protocol Compliance Log',
        'Incident Trend Chart',
      ],
      structuralPlan:
          'Clinical Oversight Hub: Aura HUD with high-priority safety metrics. Main grid contains staffing heatmaps and a detailed protocol compliance log with incident trending.',
    );
    registerRoute(
      ClinicalRoutes.intakeCoordinatorDashboard,
      PrimeCareForm.intakeCoordinatorDashboard,
      provider: intakeCoordinatorDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Total Active Intakes)',
        'Intake Funnel Chart',
        'Urgent Referral List',
        'Capacity Availability Grid',
      ],
      structuralPlan:
          'Throughput Command: Aura HUD with volume telemetry. Features a funnel visualization for intake progression and urgency-sorted referral lists.',
    );
    registerRoute(
      ClinicalRoutes.nurseDashboard,
      PrimeCareForm.nurseDashboard,
      provider: rnDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Critical Alerts)',
        'MAR (Medication Record)',
        'Nurse Assessment Grid',
      ],
      structuralPlan:
          'Nursing Command Center: Aura HUD with patient-safety telemetry. Features a comprehensive MAR and nursing assessment workflows.',
    );
    registerRoute(
      ClinicalRoutes.rnDashboard,
      PrimeCareForm.nurseDashboard,
      provider: rnDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Vitals Criticality)',
        'MAR (Medication Record)',
        'Wound Care Assessment',
        'Clinical Triage Grid',
      ],
      structuralPlan:
          'Advanced Care Console: Aura HUD with critical alert telemetry. Dominant MAR interface paired with structured wound care assessments and triage logic.',
    );
    registerRoute(
      ClinicalRoutes.therapistDashboard,
      PrimeCareForm.therapistDashboard,
      provider: rmtDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Treatment Velocity)',
        'Patient Anatomy Map',
        'SOAP Note Builder',
        'Treatment Plan View',
      ],
      structuralPlan:
          'Therapeutic Assessment Console: Aura HUD with treatment history. Interactive anatomy mapping integrated with SOAP note construction and plan tracking.',
    );
    registerRoute(
      ClinicalRoutes.pswDashboard,
      PrimeCareForm.pswDashboard,
      provider: pswDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Visit Completion %)',
        'Patient Summary Cards',
        'Task Checklist',
        'Incident Quick-Report',
      ],
      structuralPlan:
          'Field Care Portal: Aura HUD with visit throughput telemetry. Layout centers on high-visibility patient summary cards and a real-time task checklist for incident monitoring.',
    );
    registerRoute(
      ClinicalRoutes.socialWorkerDashboard,
      PrimeCareForm.socialWorkerDashboard,
      provider: socialWorkerDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Crisis Response Time)',
        'Psychosocial Observation Log',
        'Resource Mapping Tool',
        'Intervention Tracker',
      ],
      structuralPlan:
          'Social Care Command: Aura HUD with response-time telemetry. Centers on psychosocial logging and a real-time intervention tracking grid.',
    );

    registerRoute(
      ClinicalRoutes.infectionControlDashboard,
      PrimeCareForm.infectionControlDashboard,
      provider: infectionControlDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Infection Velocity)',
        'Transmission Trend',
        'Outbreak Monitoring Grid',
        'Immunization Tracker',
      ],
      structuralPlan:
          'Public Health Hub: Aura HUD with infection telemetry. Features outbreak tracking and immunization status.',
    );

    // Support-Clinical Bridge Routes
    registerRoute(
      ClinicalRoutes.customerSupportDashboard,
      PrimeCareForm.customerSupportDashboard,
      provider: customerSupportDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (MTTR)',
        'Live Ticket Queue',
        'SLA Performance Grid',
        'Customer Sentiment Hub',
      ],
      structuralPlan:
          'Service Excellence Console: Aura HUD with ticket volume telemetry. Dashboard features a live ticket queue and SLA performance monitoring.',
    );
    registerRoute(
      ClinicalRoutes.supportIntakeCoordinatorDashboard,
      PrimeCareForm.intakeCoordinatorDashboard,
      provider: intakeDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Intake Velocity)',
        'Referral Pipeline',
        'Payer Verification',
        'Coordination Log',
      ],
      structuralPlan:
          'Patient Admission Pipeline: Aura HUD with referral throughput telemetry. Features a multi-stage referral pipeline and payer verification status monitoring.',
    );
    registerRoute(
      ClinicalRoutes.qualityAssuranceDashboard,
      PrimeCareForm.qualityAssuranceDashboard,
      provider: qualityAssuranceDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Compliance Drift)',
        'Medication Safety Log',
        'Incident Trend Analysis',
        'Compliance Audit Grid',
      ],
      structuralPlan:
          'Quality Oversight Command: Aura HUD with compliance drift telemetry. Main grid displays incident trends and compliance audit results.',
    );

    // Sub-screens with explicit architectural intent
    registerRoute(
      ClinicalRoutes.intakeCoordinatorReferrals,
      PrimeCareForm.referralManagement,
      componentLabels: [
        'Aura HUD (Conversion Rate %)',
        'Referral Source Grid',
        'Lead Prioritization List',
        'Inquiry Log',
      ],
      structuralPlan:
          'Inbound Pipeline: Aura HUD with conversion telemetry. Prioritizes high-value lead processing and source-attribution analytics.',
    );
    registerRoute(
      ClinicalRoutes.intakeCoordinatorAssessments,
      PrimeCareForm.intakeAssessment,
      componentLabels: [
        'Aura HUD (Intake Time)',
        'Smart Intake Form',
        'Document Verification Status',
        'Risk Triage Indicator',
      ],
      structuralPlan:
          'Patient Onboarding Portal: Aura HUD with velocity tracking. Main section features the smart intake form builder with document verification gates.',
    );
    registerRoute(
      ClinicalRoutes.clinicalDirectorQualityMetrics,
      PrimeCareForm.qualityMetrics,
      componentLabels: [
        'Aura HUD',
        'Outcome Variance Chart',
        'Sentinel Event Log',
        'Best-Practice Audit',
      ],
      structuralPlan:
          'Clinical Governance Engine: Aura HUD with sentinel event telemetry. Layout prioritizes outcome variance visualization and rigorous best-practice audit checklists.',
    );

    // Also include Office routes that are clinical in nature
    registerRoute(
      OfficeRoutes.schedulerDashboard,
      PrimeCareForm.schedulerDashboard,
      provider: schedulerDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Shift Coverage)',
        'Scheduling Stat Grid',
        'Shift Coordination Calendar',
        'Urgent Coverage List',
      ],
      structuralPlan:
          'Coordination Hub: Aura HUD with shift coverage telemetry. Centered around a coordination calendar with an urgent remediation sidebar.',
    );
    registerRoute(
      OfficeRoutes.billingAdminDashboard,
      PrimeCareForm.billingAdminDashboard,
      provider: billingAdminDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (AR Velocity)',
        'Billing Stat Grid',
        'Pending Claims Ledger',
        'Collection Status Chart',
      ],
      structuralPlan:
          'Revenue Recovery Console: Aura HUD with AR telemetry. Primary focus on the pending claims ledger and collection status visualization.',
    );
    registerRoute(
      OfficeRoutes.hrHiringDashboard,
      PrimeCareForm.hrHiringDashboard,
      provider: hrHiringDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Pipeline Velocity)',
        'Recruitment KPI Grid',
        'Candidate Pipeline View',
        'Onboarding Checklist',
      ],
      structuralPlan:
          'Talent Pipeline Command: Aura HUD with recruitment throughput telemetry. Features a candidate pipeline and onboarding compliance checklists.',
    );
    registerRoute(
      OfficeRoutes.receptionistDashboard,
      PrimeCareForm.receptionistDashboard,
      provider: receptionistDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Visitor Flow)',
        'Receptionist KPI Grid',
        'Check-in Queue',
        'Directory Search',
      ],
      structuralPlan:
          'Front-Office Command: Aura HUD with visitor flow telemetry. Prioritizes real-time check-in management and institutional directory access.',
    );
  }

  @override
  Map<String, Map<String, dynamic>> get registryJson => {
    'clinical_director': {
      'title': 'clinical.clinical_director.dashboard.title',
      'subtitle': 'clinical.clinical_director.dashboard.subtitle',
      'route': ClinicalRoutes.clinicalDirectorDashboard,
      'componentLabels': [
        'Aura HUD (Clinical Safety Score)',
        'Staffing Heatmap',
        'Protocol Compliance Log',
        'Incident Trend Chart',
      ],
      'structuralPlan':
          'Clinical Oversight Hub: Aura HUD with high-priority safety metrics. Main grid contains staffing heatmaps and a detailed protocol compliance log with incident trending.',
      'kpis': [
        {
          'title': 'Incident Rate',
          'value': '0.1%',
          'deltaSuffix': 'Goal: < 0.5%',
          'icon': 'activity',
          'iconColor': 'green',
        },
      ],
    },
    'quality_metrics': {
      'title': 'clinical.clinical_director.quality_metrics.title',
      'subtitle': 'clinical.clinical_director.quality_metrics.subtitle',
      'route': ClinicalRoutes.clinicalDirectorQualityMetrics,
      'componentLabels': [
        'Aura HUD',
        'Outcome Variance Chart',
        'Sentinel Event Log',
        'Best-Practice Audit',
      ],
      'structuralPlan':
          'Clinical Governance Engine: Aura HUD with sentinel event telemetry. Layout prioritizes outcome variance visualization and rigorous best-practice audit checklists.',
    },
    'intake_coordinator': {
      'title': 'clinical.intake_coordinator.dashboard.title',
      'subtitle': 'clinical.intake_coordinator.dashboard.subtitle',
      'route': ClinicalRoutes.intakeCoordinatorDashboard,
      'componentLabels': [
        'Aura HUD (Total Active Intakes)',
        'Intake Funnel Chart',
        'Urgent Referral List',
        'Capacity Availability Grid',
      ],
      'structuralPlan':
          'Throughput Command: Aura HUD with volume telemetry. Features a funnel visualization for intake progression and urgency-sorted referral lists.',
    },
    'referral_management': {
      'title': 'clinical.intake_coordinator.referrals.title',
      'subtitle': 'clinical.intake_coordinator.referrals.subtitle',
      'route': ClinicalRoutes.intakeCoordinatorReferrals,
      'componentLabels': [
        'Aura HUD (Conversion Rate %)',
        'Referral Source Grid',
        'Lead Prioritization List',
        'Inquiry Log',
      ],
      'structuralPlan':
          'Inbound Pipeline: Aura HUD with conversion telemetry. Prioritizes high-value lead processing and source-attribution analytics.',
    },
    'intake_assessment': {
      'title': 'clinical.intake_coordinator.assessments.title',
      'subtitle': 'clinical.intake_coordinator.assessments.subtitle',
      'route': ClinicalRoutes.intakeCoordinatorAssessments,
      'componentLabels': [
        'Aura HUD (Intake Time)',
        'Smart Intake Form',
        'Document Verification Status',
        'Risk Triage Indicator',
      ],
      'structuralPlan':
          'Patient Onboarding Portal: Aura HUD with velocity tracking. Main section features the smart intake form builder with document verification gates.',
    },
    'psw': {
      'title': 'clinical.psw.dashboard.title',
      'subtitle': 'clinical.psw.dashboard.subtitle',
      'route': ClinicalRoutes.pswDashboard,
      'componentLabels': [
        'Aura HUD (Visit Completion %)',
        'Patient Summary Cards',
        'Task Checklist',
        'Incident Quick-Report',
      ],
      'structuralPlan':
          'Field Care Portal: Aura HUD with visit throughput telemetry. Layout centers on high-visibility patient summary cards and a real-time task checklist for incident monitoring.',
    },
    'rn': {
      'title': 'clinical.rn.dashboard.title',
      'subtitle': 'clinical.rn.dashboard.subtitle',
      'route': ClinicalRoutes.rnDashboard,
      'componentLabels': [
        'Aura HUD (Vitals Criticality)',
        'MAR (Medication Record)',
        'Wound Care Assessment',
        'Clinical Triage Grid',
      ],
      'structuralPlan':
          'Advanced Care Console: Aura HUD with critical alert telemetry. Dominant MAR interface paired with structured wound care assessments and triage logic.',
    },
    'rmt': {
      'title': 'clinical.rmt.dashboard.title',
      'subtitle': 'clinical.rmt.dashboard.subtitle',
      'route': ClinicalRoutes.therapistDashboard,
      'componentLabels': [
        'Aura HUD (Treatment Velocity)',
        'Patient Anatomy Map',
        'SOAP Note Builder',
        'Treatment Plan View',
      ],
      'structuralPlan':
          'Therapeutic Assessment Console: Aura HUD with treatment history. Interactive anatomy mapping integrated with SOAP note construction and plan tracking.',
    },
    'social_worker': {
      'title': 'clinical.social_worker.dashboard.title',
      'subtitle': 'clinical.social_worker.dashboard.subtitle',
      'route': ClinicalRoutes.socialWorkerDashboard,
      'componentLabels': [
        'Aura HUD (Crisis Response Time)',
        'Psychosocial Observation Log',
        'Resource Mapping Tool',
        'Intervention Tracker',
      ],
      'structuralPlan':
          'Social Care Command: Aura HUD with response-time telemetry. Centers on psychosocial logging and a real-time intervention tracking grid.',
    },
    'infection_control': {
      'title': 'clinical.infection_control.dashboard.title',
      'subtitle': 'clinical.infection_control.dashboard.subtitle',
      'route': ClinicalRoutes.infectionControlDashboard,
      'componentLabels': [
        'Aura HUD (Infection Velocity)',
        'Transmission Trend',
        'Outbreak Monitoring Grid',
        'Immunization Tracker',
      ],
      'structuralPlan':
          'Public Health Hub: Aura HUD with infection telemetry. Features outbreak tracking and immunization status.',
    },
    'quality_assurance': {
      'title': 'support.quality_assurance.dashboard.title',
      'subtitle': 'support.quality_assurance.dashboard.subtitle',
      'route': ClinicalRoutes.qualityAssuranceDashboard,
      'componentLabels': [
        'Aura HUD (Compliance Drift)',
        'Medication Safety Log',
        'Incident Trend Analysis',
        'Compliance Audit Grid',
      ],
      'structuralPlan':
          'Quality Oversight Command: Aura HUD with compliance drift telemetry. Main grid displays incident trends and compliance audit results.',
      'kpis': [
        {
          'title': 'Medication Errors',
          'value': '0.02%',
          'deltaSuffix': 'Below Target',
          'icon': 'shieldAlert',
          'iconColor': 'blue',
        },
      ],
    },
    'customer_support': {
      'title': 'support.customer_support.dashboard.title',
      'subtitle': 'support.customer_support.dashboard.subtitle',
      'route': ClinicalRoutes.customerSupportDashboard,
      'componentLabels': [
        'Aura HUD (MTTR)',
        'Live Ticket Queue',
        'SLA Performance Grid',
        'Customer Sentiment Hub',
      ],
      'structuralPlan':
          'Service Excellence Console: Aura HUD with ticket volume telemetry. Dashboard features a live ticket queue and SLA performance monitoring.',
      'kpis': [
        {
          'title': 'Open Tickets',
          'value': '24',
          'deltaSuffix': 'Avg wait: 4m',
          'icon': 'ticket',
          'iconColor': 'blue',
        },
      ],
    },
    'support_intake': {
      'title': 'support.intake_coordinator.dashboard.title',
      'subtitle': 'support.intake_coordinator.dashboard.subtitle',
      'route': ClinicalRoutes.supportIntakeCoordinatorDashboard,
      'componentLabels': [
        'Aura HUD (Intake Velocity)',
        'Referral Pipeline',
        'Payer Verification',
        'Coordination Log',
      ],
      'structuralPlan':
          'Patient Admission Pipeline: Aura HUD with referral throughput telemetry. Features a multi-stage referral pipeline and payer verification status monitoring.',
      'kpis': [
        {
          'title': 'New Referrals',
          'value': '12',
          'deltaSuffix': 'Today',
          'icon': 'userPlus',
          'iconColor': 'teal',
        },
      ],
    },
  };
}
