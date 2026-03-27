class AppRoutes {
  // Public
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';

  // Universal
  static const String universalChat = '/:role/chat/:threadId';
  static const String universalTelehealth = '/:role/telehealth';

  // PSW
  static const String pswHome = '/psw/home';
  static const String pswTimesheets = '/psw/timesheets';
  static const String pswEarnings = '/psw/earnings';
  static const String pswInbox = '/psw/inbox';
  static const String pswSow = '/psw/sow';
  static const String pswShiftTracker = '/psw/shift-tracker';
  static const String pswDailyEntry = '/psw/daily-entry';
  static const String pswMar = '/psw/mar';
  static const String pswProgressNotes = '/psw/progress-notes';
  static const String pswIncidentReport = '/psw/incident-report';

  // RN
  static const String rnHome = '/rn/home';
  static const String rnCarePlan = '/rn/care-plan';
  static const String rnInbox = '/rn/inbox';
  static const String rnSow = '/rn/sow';

  // Coordinator
  static const String coordinatorHome = '/coordinator/home';
  static const String coordinatorApprovals = '/coordinator/approvals';
  static const String coordinatorCallin = '/coordinator/callin';
  static const String coordinatorVisitAdjust = '/coordinator/visit-adjust';
  static const String coordinatorInbox = '/coordinator/inbox';
  static const String coordinatorSow = '/coordinator/sow';

  // Manager
  static const String managerHome = '/manager/home';
  static const String managerTeams = '/manager/teams';
  static const String managerPayroll = '/manager/payroll';
  static const String managerIncidents = '/manager/incidents';
  static const String managerInbox = '/manager/inbox';
  static const String managerSow = '/manager/sow';

  // Admin
  static const String adminHome = '/admin/home';
  static const String adminAudit = '/admin/audit';
  static const String adminTelemetry = '/admin/telemetry';
  static const String adminForms = '/admin/forms';
  static const String adminInbox = '/admin/inbox';
  static const String adminSow = '/admin/sow';
  static const String adminRoles = '/admin/roles';

  // Client
  static const String clientHome = '/client/home';
  static const String clientPulse = '/client/pulse';
  static const String clientDispatch = '/client/dispatch';
  static const String clientPayments = '/client/payments';
  static const String clientInbox = '/client/inbox';

  // Superuser
  static const String superuserHome = '/superuser/home';
  static const String superuserTerritory = '/superuser/territory';
  static const String superuserRegistry = '/superuser/registry';
  static const String superuserSow = '/superuser/sow';

  // Scrum Master
  static const String scrumMasterHome = '/scrum_master/home';

  // GM
  static const String gmHome = '/gm/home';
  static const String gmHomeAlt = '/gm_home';
  static const String gmPnl = '/gm/pnl';
  static const String gmInbox = '/gm/inbox';
  static const String gmSow = '/gm/sow';

  // MT
  static const String mtHome = '/mt/home';
  static const String mtSurgeConfig = '/mt/surge-config';
  static const String mtInbox = '/mt/inbox';
  static const String mtSow = '/mt/sow';
}
