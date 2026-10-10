// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE Global granular toggles to merge Mock + API data on the same app
// Layer: 01_INFRASTRUCTURE
class FeatureFlags {
  // Global granular toggles to merge Mock + API data on the same app
  static bool useApiForProviderDashboard = true;
  static bool useApiForClientProfile = true;
  static bool useApiForVisitDetails = true;
  static bool useApiForBillingSummary = true;

  /// Defines conditional UI flows based on backend readiness or A/B testing
  static const bool enableNewVisitFlow = true;
  static const bool useDashboardV2 = false;
}
