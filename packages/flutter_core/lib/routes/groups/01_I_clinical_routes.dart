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

  static const String rnDashboard = '/offices/clinical/roles/rn/dashboard';
  static const String rmtDashboard = '/offices/clinical/roles/rmt/dashboard';
  static const String nurseDashboard = '/offices/clinical/roles/nurse/dashboard';
  static const String physicianDashboard = '/offices/clinical/roles/physician/dashboard';
  static const String pswDashboard = '/offices/clinical/roles/psw/dashboard';
  static const String careGiverDashboard = '/offices/clinical/roles/caregiver/dashboard';
  static const String therapistDashboard = '/offices/clinical/roles/therapist/dashboard';
  static const String socialWorkerDashboard = '/offices/clinical/roles/social_worker/dashboard';
}
