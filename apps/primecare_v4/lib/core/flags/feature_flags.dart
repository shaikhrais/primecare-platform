class FeatureFlags {
  /// Defines conditional UI flows based on backend readiness or A/B testing
  static const bool enableNewVisitFlow = true;
  static const bool useDashboardV2 = false;
  
  /// Global escape hatch to bypass strict Role Checks during development
  static const bool bypassStrictRbac = false;
}
