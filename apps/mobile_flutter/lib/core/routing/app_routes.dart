class AppRoutes {
  // Public
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';

  // Universal
  static const String universalChat = '/:role/chat/:threadId';
  static const String universalTelehealth = '/:role/telehealth';

  // Granular Enterprise Domain Dashboard Routes (Phase 24/43 36-Role Mappings)
  
  // 1. Corporate
  static const String founderCeoDashboard = '/corporate/founder-ceo';
  static const String cooDashboard = '/corporate/coo';
  static const String cfoDashboard = '/corporate/cfo';
  static const String ctoDashboard = '/corporate/cto';
  static const String complianceDashboard = '/corporate/compliance';
  static const String headBdDashboard = '/corporate/head-bd';
  static const String headMarketingDashboard = '/corporate/head-marketing';
  static const String trainingDirectorDashboard = '/corporate/training-director';
  
  // 2. Business Development
  static const String bdTeamDashboard = '/business-development/bd-team';
  static const String regionalBdOnDashboard = '/business-development/regional-bd-on';
  static const String regionalBdUsaDashboard = '/business-development/regional-bd-usa';
  static const String franchiseSalesDashboard = '/business-development/franchise-sales';
  static const String partnershipMgrDashboard = '/business-development/partnership-mgr';
  static const String territoryExpansionDashboard = '/business-development/territory-expansion';
  
  // 3. Franchise Management
  static const String franchiseLevelDashboard = '/franchise-management/franchise-level';
  static const String franchiseOwnerDashboard = '/franchise-management/franchise-owner';
  static const String operationsMgrDashboard = '/franchise-management/operations-mgr';
  static const String schedulerDashboard = '/franchise-management/scheduler';
  static const String billingDashboard = '/franchise-management/billing';
  static const String hrDashboard = '/franchise-management/hr';
  
  // 4. Clinical
  static const String clinicalTeamDashboard = '/clinical/clinical-team';
  static const String rnGranularDashboard = '/clinical/rn-granular';
  static const String rpnDashboard = '/clinical/rpn';
  static const String rmtDashboard = '/clinical/rmt';
  static const String pswGranularDashboard = '/clinical/psw-granular';
  
  // 5. Support
  static const String supportTeamDashboard = '/support/support-team';
  static const String customerSupportDashboard = '/support/customer-support';
  static const String intakeCoordinatorDashboard = '/support/intake-coordinator';
  static const String qualityAssuranceDashboard = '/support/quality-assurance';
  static const String trainingCoordinatorDashboard = '/support/training-coordinator';
  
  // 6. Marketing
  static const String marketingGrowthDashboard = '/marketing/marketing-growth';
  static const String localMarketingDashboard = '/marketing/local-marketing';
  static const String communityOutreachDashboard = '/marketing/community-outreach';
  static const String territorySalesDashboard = '/marketing/territory-sales';
  
  // 7. Client
  static const String clientSideDashboard = '/client/client-side';
  static const String clientGranularDashboard = '/client/client-granular';
  static const String familyMemberDashboard = '/client/family-member';

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
