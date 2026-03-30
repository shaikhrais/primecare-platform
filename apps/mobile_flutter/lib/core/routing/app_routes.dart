class AppRoutes {
  // Public
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';

  // Universal
  static const String universalChat = '/:role/chat/:threadId';
  static const String universalTelehealth = '/:role/telehealth';

  // Granular Enterprise Domain Dashboard Routes (Phase 24/43 36-Role Mappings)
  
  // 1. Corporate
  static const String founderCeoDashboard = '/corporate/ceo';
  static const String cooDashboard = '/corporate/coo';
  static const String cfoDashboard = '/corporate/cfo';
  static const String ctoDashboard = '/corporate/cto';
  static const String complianceDashboard = '/corporate/compliance';
  static const String headBdDashboard = '/corporate/bd';
  static const String headMarketingDashboard = '/corporate/marketing';
  static const String trainingDirectorDashboard = '/corporate/training';
  
  // 2. Business Development
  static const String bdTeamDashboard = '/bd/team';
  static const String regionalBdOnDashboard = '/bd/regional-on';
  static const String regionalBdUsaDashboard = '/bd/regional-usa';
  static const String franchiseSalesDashboard = '/bd/franchise-sales';
  static const String partnershipMgrDashboard = '/bd/partnerships';
  static const String territoryExpansionDashboard = '/bd/expansion';
  
  // 3. Franchise Management
  static const String franchiseLevelDashboard = '/franchise/level';
  static const String franchiseOwnerDashboard = '/franchise/owner';
  static const String operationsMgrDashboard = '/franchise/operations';
  static const String schedulerDashboard = '/franchise/scheduler';
  static const String billingDashboard = '/franchise/billing';
  static const String hrDashboard = '/franchise/hr';
  
  // 4. Clinical
  static const String clinicalTeamDashboard = '/clinical/team';
  static const String rnGranularDashboard = '/clinical/rn';
  static const String rpnDashboard = '/clinical/rpn';
  static const String rmtDashboard = '/clinical/rmt';
  static const String pswGranularDashboard = '/clinical/psw';
  
  // 5. Support
  static const String supportTeamDashboard = '/support/team';
  static const String customerSupportDashboard = '/support/customers';
  static const String intakeCoordinatorDashboard = '/support/intake';
  static const String qualityAssuranceDashboard = '/support/qa';
  static const String trainingCoordinatorDashboard = '/support/training';
  
  // 6. Marketing
  static const String marketingGrowthDashboard = '/marketing/growth';
  static const String localMarketingDashboard = '/marketing/local';
  static const String communityOutreachDashboard = '/marketing/outreach';
  static const String territorySalesDashboard = '/marketing/territory-sales';
  
  // 7. Client
  static const String clientSideDashboard = '/client/dashboard';
  static const String clientGranularDashboard = '/client/portal';
  static const String familyMemberDashboard = '/client/family';

  // Legacy Map Safeties for auto-generated files
  static const String clientHome = '/legacy/clientHome';
  static const String clientPulse = '/legacy/clientPulse';
  static const String clientDispatch = '/legacy/clientDispatch';
  static const String clientPayments = '/legacy/clientPayments';
  static const String clientInbox = '/legacy/clientInbox';
  static const String rnCarePlan = '/legacy/rnCarePlan';
  static const String rnInbox = '/legacy/rnInbox';
  static const String rnSow = '/legacy/rnSow';
}
