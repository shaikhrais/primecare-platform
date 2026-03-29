class AppRoutes {
  // Public
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';

  // Universal
  static const String universalChat = '/:role/chat/:threadId';
  static const String universalTelehealth = '/:role/telehealth';

  // PSW
  static const String pswHome = '/psw/home';
  static const String pswLiveVisit = '/psw/live-visit';
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

  // Granular Dashboard Routes
  static const String founderCeoDashboard = '/corporate/founder-ceo';
  static const String cooDashboard = '/corporate/coo';
  static const String cfoDashboard = '/corporate/cfo';
  static const String ctoDashboard = '/corporate/cto';
  static const String complianceDashboard = '/corporate/compliance';
  static const String headBdDashboard = '/corporate/head-bd';
  static const String headMarketingDashboard = '/corporate/head-marketing';
  static const String trainingDirectorDashboard = '/corporate/training-director';
  static const String bdTeamDashboard = '/business-development/bd-team';
  static const String regionalBdOnDashboard = '/business-development/regional-bd-on';
  static const String regionalBdUsaDashboard = '/business-development/regional-bd-usa';
  static const String franchiseSalesDashboard = '/business-development/franchise-sales';
  static const String partnershipMgrDashboard = '/business-development/partnership-mgr';
  static const String territoryExpansionDashboard = '/business-development/territory-expansion';
  static const String franchiseLevelDashboard = '/franchise-management/franchise-level';
  static const String franchiseOwnerDashboard = '/franchise-management/franchise-owner';
  static const String operationsMgrDashboard = '/franchise-management/operations-mgr';
  static const String schedulerDashboard = '/franchise-management/scheduler';
  static const String billingDashboard = '/franchise-management/billing';
  static const String hrDashboard = '/franchise-management/hr';
  static const String clinicalTeamDashboard = '/clinical/clinical-team';
  static const String rnGranularDashboard = '/clinical/rn-granular';
  static const String rpnDashboard = '/clinical/rpn';
  static const String rmtDashboard = '/clinical/rmt';
  static const String pswGranularDashboard = '/clinical/psw-granular';
  static const String supportTeamDashboard = '/support/support-team';
  static const String customerSupportDashboard = '/support/customer-support';
  static const String intakeCoordinatorDashboard = '/support/intake-coordinator';
  static const String qualityAssuranceDashboard = '/support/quality-assurance';
  static const String trainingCoordinatorDashboard = '/support/training-coordinator';
  static const String marketingGrowthDashboard = '/marketing/marketing-growth';
  static const String localMarketingDashboard = '/marketing/local-marketing';
  static const String communityOutreachDashboard = '/marketing/community-outreach';
  static const String territorySalesDashboard = '/marketing/territory-sales';
  static const String clientSideDashboard = '/client/client-side';
  static const String clientGranularDashboard = '/client/client-granular';
  static const String familyMemberDashboard = '/client/family-member';
}
