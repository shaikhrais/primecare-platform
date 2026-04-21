// Layer: 01_INFRASTRUCTURE
class ClinicalRoutes {
  const ClinicalRoutes._();

  static const String clinicalDirectorDashboard =
      '/offices/clinical/roles/clinical_director/dashboard';
  static const String clinicalDirectorQualityMetrics =
      '/offices/clinical/roles/clinical_director/quality-metrics';
  static const String clinicalDirectorStaffing =
      '/offices/clinical/roles/clinical_director/staffing';

  static const String intakeCoordinatorDashboard =
      '/offices/clinical/roles/intake_coordinator/dashboard';
  static const String intakeCoordinatorReferrals =
      '/offices/clinical/roles/intake_coordinator/referrals';
  static const String intakeCoordinatorAssessments =
      '/offices/clinical/roles/intake_coordinator/assessments';
}
