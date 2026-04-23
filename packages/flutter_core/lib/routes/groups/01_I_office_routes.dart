// Layer: 01_INFRASTRUCTURE
class OfficeRoutes {
  const OfficeRoutes._();

  static const String receptionistDashboard =
      '/offices/roles/receptionist/dashboard';
  static const String schedulerDashboard =
      '/offices/roles/scheduler/dashboard';
  static const String billingAdminDashboard =
      '/offices/roles/billing_admin/dashboard';
  static const String hrHiringDashboard =
      '/offices/roles/hr_hiring/dashboard';

  // Specific screens
  static const String receptionistCalls = '/offices/roles/receptionist/calls';
  static const String receptionistAppointments = '/offices/roles/receptionist/appointments';
  static const String receptionistVisitors = '/offices/roles/receptionist/visitors';

  static const String schedulerCalendar = '/offices/roles/scheduler/calendar';
  static const String schedulerShifts = '/offices/roles/scheduler/shifts';
  static const String schedulerProviderAvailability = '/offices/roles/scheduler/availability';

  static const String billingInvoices = '/offices/roles/billing/invoices';
  static const String billingPayments = '/offices/roles/billing/payments';
  static const String billingClaims = '/offices/roles/billing/claims';

  static const String hrApplicants = '/offices/roles/hr/applicants';
  static const String hrOnboarding = '/offices/roles/hr/onboarding';
  static const String hrStaffFiles = '/offices/roles/hr/staff-files';
}
