/// Primary subsystems across the PrimeCare Platform.
enum PlatformSubsystem {
  clinical,
  corporate,
  system,
  finance,
  governance,
  operations,
  metrics,
  office,
  infrastructure,
  portal,
  franchise,
}

/// Defines the type of shell layout to use for the application.
enum AppShellType { admin, clinical, patient, system, provider }

/// Standardized labels for UI components and classification.
enum PrimeCareLabel {
  dashboard,
  metrics,
  timeline,
  insights,
  analytics,
  registry,
  controls,
  form,
  report,
}

/// Standardized form definitions for the platform.
enum PrimeCareForm {
  patientIntake,
  staffOnboarding,
  billingSubmission,
  incidentReport,
  carePlan,
  schedulerEntry,
  ceoDashboard,
  pswDashboard,
}

extension PrimeCareLabelExtension on PrimeCareLabel {
  String get(String langCode) {
    final translations = {
      'en': {
        PrimeCareLabel.dashboard: 'Dashboard',
        PrimeCareLabel.metrics: 'Metrics',
        PrimeCareLabel.timeline: 'Timeline',
        PrimeCareLabel.insights: 'Insights',
        PrimeCareLabel.analytics: 'Analytics',
        PrimeCareLabel.registry: 'Registry',
        PrimeCareLabel.controls: 'Controls',
        PrimeCareLabel.form: 'Form',
        PrimeCareLabel.report: 'Report',
      },
    };
    return translations[langCode]?[this] ?? name;
  }
}
