import 'package:primecare_ui/primecare_ui.dart';
import '../office_screen_registry.dart';

class ClinicalRegistry extends OfficeScreenRegistry {
  @override
  void bootstrap() {
    registerRoute(
      ClinicalRoutes.clinicalDirectorDashboard,
      PrimeCareForm.clinicalDirectorDashboard,
      provider: clinicalDirectorDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD',
        'Clinical Safety Score',
        'Staffing Heatmap',
        'Protocol Compliance',
      ],
      structuralPlan:
          'Clinical Oversight Hub: Aura HUD with high-priority safety metrics. Main grid contains staffing heatmaps and a detailed protocol compliance log with incident trending.',
    );
    registerRoute(
      ClinicalRoutes.intakeCoordinatorDashboard,
      PrimeCareForm.intakeCoordinatorDashboard,
      provider: intakeCoordinatorDashboardAdapterProvider,
      titleKey: LocaleKeys.intake_dashboard_title,
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
      PrimeCareForm.rnDashboard,
      provider: rnDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD',
        'Medication Administration Record',
        'Wound Care Module',
      ],
      structuralPlan:
          'Advanced Care Console: Aura HUD with critical alert telemetry. Dominant MAR interface paired with structured wound care assessments and triage logic.',
    );
    registerRoute(
      ClinicalRoutes.rpnDashboard,
      PrimeCareForm.rpnDashboard,
      provider: rpnDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD',
        'Vitals Monitor',
        'Medication Queue',
        'Shift Handover Notes',
      ],
      structuralPlan:
          'Practical Nursing Hub: Aura HUD with vital signs monitoring. Features a medication queue and structured shift handover notes.',
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
        'Visit Timeline Card',
        'Live Task Burn-down Sparkline',
        'Incident Quick-Report',
      ],
      structuralPlan:
          'PSW Command Center: Aura HUD with SHIFT THROUGHPUT (4/6 Visits Completed). VisitTimelineCard showing current and next 2 visits with mini-maps. Live "Task Burn-down" sparkline for telemetry.',
    );
    registerRoute(
      ClinicalRoutes.pswVisitChecklist,
      PrimeCareForm.pswVisitChecklist,
      provider: pswDashboardAdapterProvider,
      componentLabels: [
        'Patient Bio Summary',
        'Interactive Checklist (Hygiene, Nutrition, Mobility)',
        'Unplanned Observation FAB',
      ],
      structuralPlan:
          'Care Plan Checklist: Patient Bio Summary with DNR/Allergy Alerts. InteractiveChecklist grouped by Hygiene, Nutrition, and Mobility. Floating Action Button for Unplanned Observations.',
    );
    registerRoute(
      ClinicalRoutes.pswObservationVitalsLog,
      PrimeCareForm.pswObservationVitalsLog,
      provider: pswDashboardAdapterProvider,
      componentLabels: [
        'Aura Form Container (Mood/Pain)',
        'High-Precision Vitals Input',
        'Vital Trends Sparkline',
      ],
      structuralPlan:
          'Clinical Data Entry: AuraFormContainer with interactive sliders for Mood and Pain assessments. High-precision inputs for Temp, BP, and O2. Sparkline visualization of 24h vital trends.',
    );
    registerRoute(
      ClinicalRoutes.pswIncidentReport,
      PrimeCareForm.pswIncidentReport,
      provider: pswDashboardAdapterProvider,
      componentLabels: [
        'Urgency Grid (Fall, Refusal, Skin)',
        'Evidence Camera Interface',
        'Immediate Assistance Trigger',
      ],
      structuralPlan:
          'Safety Reporting Hub: High-contrast urgency grid with large-tap targets for Fall, Refusal, and Skin incidents. Integrated camera interface for photo evidence and floating red Immediate Assistance trigger.',
    );
    registerRoute(
      ClinicalRoutes.pswPatientProfile,
      PrimeCareForm.pswPatientProfile,
      provider: pswDashboardAdapterProvider,
      componentLabels: [
        'Patient Avatar & QR Code',
        'Medical History Card',
        'Clinical Precautions Banner',
      ],
      structuralPlan:
          'Patient Digital Passport: Patient Avatar with secure QR bedside verification. PrimeCareV4Cards for medical history, preferred routines, and family contacts. Persistent Clinical Precautions banner.',
    );
    registerRoute(
      ClinicalRoutes.pswSchedule,
      PrimeCareForm.pswSchedule,
      provider: pswDashboardAdapterProvider,
      componentLabels: [
        'Integrated Route Map',
        'Time-Blocked Roster Cards',
        'Smart-Travel Estimates',
      ],
      structuralPlan:
          'Logistics & Travel: Integrated route visualization for the full shift. Time-blocked cards showing travel vs. care duration with smart-travel time estimates and navigation actions.',
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
      ClinicalRoutes.chiropractorDashboard,
      PrimeCareForm.chiropractorDashboard,
      provider: chiropractorDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD',
        'Patient Spine Health Tracker',
        'Adjustment Protocol Log',
        'Imaging View',
      ],
      structuralPlan:
          'Chiropractic Care Portal: Aura HUD with recovery-rate telemetry. Core features include a spine health tracker and a detailed adjustment protocol log with integrated imaging view.',
    );
    registerRoute(
      ClinicalRoutes.physiotherapistDashboard,
      PrimeCareForm.physiotherapistDashboard,
      provider: physiotherapistDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD',
        'Mobility Progress Chart',
        'Treatment Session Timer',
        'Rehab Plan Builder',
      ],
      structuralPlan:
          'Physiotherapy Rehabilitation Center: Aura HUD with mobility telemetry. Features a progress chart, session timing interface, and a drag-and-drop rehab plan builder.',
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
          'Service Excellence Console: Aura HUD with ticket volume telemetry. Dashboards features a live ticket queue and SLA performance monitoring.',
    );
    registerRoute(
      ClinicalRoutes.supportIntakeCoordinatorDashboard,
      PrimeCareForm.intakeCoordinatorDashboard,
      provider: intakeDashboardAdapterProvider,
      titleKey: LocaleKeys.intake_dashboard_title,
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
      titleKey: LocaleKeys.quality_assurance_dashboard_title,
      componentLabels: [
        'Aura HUD (Compliance Drift)',
        'Medication Safety Log',
        'Incident Trend Analysis',
        'Compliance Audit Grid',
      ],
      structuralPlan:
          'Quality Oversight Command: Aura HUD with compliance drift telemetry. Main grid displays incident trends and compliance audit results.',
    );

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
          'Clinical Governance Engine: Aura HUD with sentinel event telemetry. AuthLayout prioritizes outcome variance visualization and rigorous best-practice audit checklists.',
    );

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
        'Aura HUD',
        'Candidate Pipeline',
        'Onboarding Checklist',
        'Recruitment KPI Grid',
      ],
      structuralPlan:
          'Talent Pipeline Command: Aura HUD with recruitment throughput telemetry. Features a candidate pipeline and onboarding compliance checklists.',
    );

    registerRoute(
      '/offices/roles/patient/dashboard',
      PrimeCareForm.patientDashboard,
      provider: patientDashboardAdapterProvider,
      titleKey: LocaleKeys.patient_dashboard_title,
      componentLabels: [
        'Aura HUD (Wellness Score)',
        'Action Hub',
        'Care Plan Progress',
        'Vitals Telemetry',
      ],
      structuralPlan:
          'Patient Command Center: Aura HUD with wellness telemetry. Features care plan tracking and vital signs monitoring.',
    );
    registerRoute(
      '/offices/roles/partnership_manager/dashboard',
      PrimeCareForm.partnershipManagerDashboard,
      provider: partnershipManagerDashboardAdapterProvider,
      titleKey: LocaleKeys.partnership_manager_dashboard_title,
      componentLabels: [
        'Aura HUD (Partnership Health)',
        'Contract Lifecycle Grid',
        'Revenue Share Analytics',
        'Referral Network Map',
      ],
      structuralPlan:
          'Partnership Command Center: Aura HUD with alliance health telemetry. Tracks contract lifecycles and referral network growth.',
    );
    registerRoute(
      '/offices/roles/owner/dashboard',
      PrimeCareForm.ownerDashboard,
      provider: ownerDashboardAdapterProvider,
      titleKey: LocaleKeys.owner_dashboard_title,
      componentLabels: [
        'Aura HUD (Enterprise Valuation)',
        'Portfolio Performance Grid',
        'Strategic Growth Insights',
        'Global Risk Assessment',
      ],
      structuralPlan:
          'Owner Command Center: Aura HUD with enterprise telemetry. High-level portfolio performance and strategic growth monitoring.',
    );
    registerRoute(
      '/offices/roles/franchise_owner/dashboard',
      PrimeCareForm.franchiseOwnerDashboard,
      provider: franchiseOwnerAdapterProvider,
      titleKey: LocaleKeys.franchise_owner_dashboard_title,
      componentLabels: [
        'Aura HUD (Unit Profitability)',
        'Operational Health Grid',
        'Staffing Utilization',
        'Revenue Projections',
      ],
      structuralPlan:
          'Franchise Owner Command: Aura HUD with profitability telemetry. Regional performance and operational health monitoring.',
    );
    registerRoute(
      '/offices/roles/local_marketing_manager/dashboard',
      PrimeCareForm.localMarketingManagerDashboard,
      provider: localMarketingManagerDashboardAdapterProvider,
      titleKey: LocaleKeys.local_marketing_manager_dashboard_title,
      componentLabels: [
        'Aura HUD (Lead Velocity)',
        'Campaign Performance Grid',
        'Referral Source Tracking',
        'Outreach Event Calendar',
      ],
      structuralPlan:
          'Local Marketing Command: Aura HUD with lead telemetry. Local community outreach and lead generation tracking.',
    );
  }

  @override
  Map<String, Map<String, dynamic>> get registryJson => {
    'clinical_director': {
      'title': 'clinical.clinical_director.dashboard.title',
      'subtitle': 'clinical.clinical_director.dashboard.subtitle',
      'route': ClinicalRoutes.clinicalDirectorDashboard,
      'componentLabels': [
        'Clinical Safety Score',
        'Staffing Heatmap',
        'Protocol Compliance',
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
          'Clinical Governance Engine: Aura HUD with sentinel event telemetry. AuthLayout prioritizes outcome variance visualization and rigorous best-practice audit checklists.',
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
    'psw_dashboard': {
      'title': 'clinical.psw.dashboard.title',
      'subtitle': 'clinical.psw.dashboard.subtitle',
      'route': ClinicalRoutes.pswDashboard,
      'componentLabels': [
        'Aura HUD (Visit Completion %)',
        'Visit Timeline Card',
        'Live Task Burn-down Sparkline',
        'Incident Quick-Report',
      ],
      'structuralPlan':
          'PSW Command Center: Aura HUD with SHIFT THROUGHPUT (4/6 Visits Completed). VisitTimelineCard showing current and next 2 visits with mini-maps. Live "Task Burn-down" sparkline for telemetry.',
    },
    'psw_visit_checklist': {
      'title': 'clinical.psw.visit_checklist.title',
      'subtitle': 'clinical.psw.visit_checklist.subtitle',
      'route': ClinicalRoutes.pswVisitChecklist,
      'componentLabels': [
        'Patient Bio Summary',
        'Interactive Checklist (Hygiene, Nutrition, Mobility)',
        'Unplanned Observation FAB',
      ],
      'structuralPlan':
          'Care Plan Checklist: Patient Bio Summary with DNR/Allergy Alerts. InteractiveChecklist grouped by Hygiene, Nutrition, and Mobility. Floating Action Button for Unplanned Observations.',
    },
    'psw_observation_vitals_log': {
      'title': 'clinical.psw.observation_vitals_log.title',
      'subtitle': 'clinical.psw.observation_vitals_log.subtitle',
      'route': ClinicalRoutes.pswObservationVitalsLog,
      'componentLabels': [
        'Aura Form Container (Mood/Pain)',
        'High-Precision Vitals Input',
        'Vital Trends Sparkline',
      ],
      'structuralPlan':
          'Clinical Data Entry: AuraFormContainer with interactive sliders for Mood and Pain assessments. High-precision inputs for Temp, BP, and O2. Sparkline visualization of 24h vital trends.',
    },
    'psw_incident_report': {
      'title': 'clinical.psw.incident_report.title',
      'subtitle': 'clinical.psw.incident_report.subtitle',
      'route': ClinicalRoutes.pswIncidentReport,
      'componentLabels': [
        'Urgency Grid (Fall, Refusal, Skin)',
        'Evidence Camera Interface',
        'Immediate Assistance Trigger',
      ],
      'structuralPlan':
          'Safety Reporting Hub: High-contrast urgency grid with large-tap targets for Fall, Refusal, and Skin incidents. Integrated camera interface for photo evidence and floating red Immediate Assistance trigger.',
    },
    'psw_patient_profile': {
      'title': 'clinical.psw.patient_profile.title',
      'subtitle': 'clinical.psw.patient_profile.subtitle',
      'route': ClinicalRoutes.pswPatientProfile,
      'componentLabels': [
        'Patient Avatar & QR Code',
        'Medical History Card',
        'Clinical Precautions Banner',
      ],
      'structuralPlan':
          'Patient Digital Passport: Patient Avatar with secure QR bedside verification. PrimeCareV4Cards for medical history, preferred routines, and family contacts. Persistent Clinical Precautions banner.',
    },
    'psw_schedule': {
      'title': 'clinical.psw.schedule.title',
      'subtitle': 'clinical.psw.schedule.subtitle',
      'route': ClinicalRoutes.pswSchedule,
      'componentLabels': [
        'Integrated Route Map',
        'Time-Blocked Roster Cards',
        'Smart-Travel Estimates',
      ],
      'structuralPlan':
          'Logistics & Travel: Integrated route visualization for the full shift. Time-blocked cards showing travel vs. care duration with smart-travel time estimates and navigation actions.',
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
    'rpn': {
      'title': 'clinical.rpn.dashboard.title',
      'subtitle': 'clinical.rpn.dashboard.subtitle',
      'route': ClinicalRoutes.rpnDashboard,
      'componentLabels': [
        'Aura HUD',
        'Vitals Monitor',
        'Medication Queue',
        'Shift Handover Notes',
      ],
      'structuralPlan':
          'Practical Nursing Hub: Aura HUD with vital signs monitoring. Features a medication queue and structured shift handover notes.',
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
          'Service Excellence Console: Aura HUD with ticket volume telemetry. Dashboards features a live ticket queue and SLA performance monitoring.',
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
          'title': 'New ScaffoldedReferrals',
          'value': '12',
          'deltaSuffix': 'Today',
          'icon': 'userPlus',
          'iconColor': 'teal',
        },
      ],
    },
  };
}
