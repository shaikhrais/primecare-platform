// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - partnership", () => {
  it("tests all screens for role partnership", () => {
    cy.loginAsRole("partnership");


  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/11 | 9%] - Navigating to /offices/business_development/roles/partnership_manager/dashboard (PartnershipManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/business_development/roles/partnership_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/11 | 9%] - Checking shell & content for PartnershipManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagerdashboard-screen").should("be.visible");
  cy.getCy("partnershipmanagerdashboard-title").should("be.visible");
  cy.getCy("partnershipmanagerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/11 | 9%] - Saving screenshot for PartnershipManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("partnership_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/11 | 9%] - Verified PartnershipManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/11 | 18%] - Navigating to /management/partnership-manager-analytics (PartnershipManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/partnership-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/11 | 18%] - Checking shell & content for PartnershipManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanageranalytics-screen").should("be.visible");
  cy.getCy("partnershipmanageranalytics-title").should("be.visible");
  cy.getCy("partnershipmanageranalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/11 | 18%] - Saving screenshot for PartnershipManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("partnership_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/11 | 18%] - Verified PartnershipManagerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/11 | 27%] - Navigating to /management/partnership-manager-compliance (PartnershipManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/partnership-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/11 | 27%] - Checking shell & content for PartnershipManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagercompliance-screen").should("be.visible");
  cy.getCy("partnershipmanagercompliance-title").should("be.visible");
  cy.getCy("partnershipmanagercompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/11 | 27%] - Saving screenshot for PartnershipManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("partnership_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/11 | 27%] - Verified PartnershipManagerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/11 | 36%] - Navigating to /management/partnership-manager-workflow (PartnershipManagerWorkflowScreen)...");
  cy.visitWithSemantics("/management/partnership-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/11 | 36%] - Checking shell & content for PartnershipManagerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagerworkflow-screen").should("be.visible");
  cy.getCy("partnershipmanagerworkflow-title").should("be.visible");
  cy.getCy("partnershipmanagerworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/11 | 36%] - Saving screenshot for PartnershipManagerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("partnership_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/11 | 36%] - Verified PartnershipManagerWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/11 | 45%] - Navigating to /management/partnership-management (PartnershipManagementScreen)...");
  cy.visitWithSemantics("/management/partnership-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/11 | 45%] - Checking shell & content for PartnershipManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagement-screen").should("be.visible");
  cy.getCy("partnershipmanagement-title").should("be.visible");
  cy.getCy("partnershipmanagement-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/11 | 45%] - Saving screenshot for PartnershipManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("partnership_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/11 | 45%] - Verified PartnershipManagementScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/11 | 54%] - Navigating to /offices/business_development/roles/partnership_manager/active-deals (Partnership Manager Active Deals)...");
  cy.visitWithSemantics("/offices/business_development/roles/partnership_manager/active-deals");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/11 | 54%] - Checking shell & content for Partnership Manager Active Deals...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnership manager active deals-screen").should("be.visible");
  cy.getCy("partnership manager active deals-title").should("be.visible");
  cy.getCy("partnership manager active deals-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/11 | 54%] - Saving screenshot for Partnership Manager Active Deals...");
  cy.waitAndSee();
  cy.screenshot("partnership_manager_active_deals");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/11 | 54%] - Verified Partnership Manager Active Deals successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [7/11 | 63%] - Navigating to /offices/business_development/roles/partnership_manager/outreach (Partnership Manager Outreach)...");
  cy.visitWithSemantics("/offices/business_development/roles/partnership_manager/outreach");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [7/11 | 63%] - Checking shell & content for Partnership Manager Outreach...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnership manager outreach-screen").should("be.visible");
  cy.getCy("partnership manager outreach-title").should("be.visible");
  cy.getCy("partnership manager outreach-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [7/11 | 63%] - Saving screenshot for Partnership Manager Outreach...");
  cy.waitAndSee();
  cy.screenshot("partnership_manager_outreach");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [7/11 | 63%] - Verified Partnership Manager Outreach successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [8/11 | 72%] - Navigating to /offices/business_development/roles/partnership_manager/partners (Partnership Manager Partners)...");
  cy.visitWithSemantics("/offices/business_development/roles/partnership_manager/partners");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [8/11 | 72%] - Checking shell & content for Partnership Manager Partners...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnership manager partners-screen").should("be.visible");
  cy.getCy("partnership manager partners-title").should("be.visible");
  cy.getCy("partnership manager partners-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [8/11 | 72%] - Saving screenshot for Partnership Manager Partners...");
  cy.waitAndSee();
  cy.screenshot("partnership_manager_partners");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [8/11 | 72%] - Verified Partnership Manager Partners successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [9/11 | 81%] - Navigating to /offices/business_development/roles/partnership_manager/proposals (Partnership Manager Proposals)...");
  cy.visitWithSemantics("/offices/business_development/roles/partnership_manager/proposals");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [9/11 | 81%] - Checking shell & content for Partnership Manager Proposals...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnership manager proposals-screen").should("be.visible");
  cy.getCy("partnership manager proposals-title").should("be.visible");
  cy.getCy("partnership manager proposals-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [9/11 | 81%] - Saving screenshot for Partnership Manager Proposals...");
  cy.waitAndSee();
  cy.screenshot("partnership_manager_proposals");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [9/11 | 81%] - Verified Partnership Manager Proposals successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [10/11 | 90%] - Navigating to /offices/business_development/roles/partnership_manager/renewals (Partnership Manager Renewals)...");
  cy.visitWithSemantics("/offices/business_development/roles/partnership_manager/renewals");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [10/11 | 90%] - Checking shell & content for Partnership Manager Renewals...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnership manager renewals-screen").should("be.visible");
  cy.getCy("partnership manager renewals-title").should("be.visible");
  cy.getCy("partnership manager renewals-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [10/11 | 90%] - Saving screenshot for Partnership Manager Renewals...");
  cy.waitAndSee();
  cy.screenshot("partnership_manager_renewals");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [10/11 | 90%] - Verified Partnership Manager Renewals successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [11/11 | 100%] - Navigating to /offices/business_development/roles/partnership_manager/reports (Partnership Manager Reports)...");
  cy.visitWithSemantics("/offices/business_development/roles/partnership_manager/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [11/11 | 100%] - Checking shell & content for Partnership Manager Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnership manager reports-screen").should("be.visible");
  cy.getCy("partnership manager reports-title").should("be.visible");
  cy.getCy("partnership manager reports-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [11/11 | 100%] - Saving screenshot for Partnership Manager Reports...");
  cy.waitAndSee();
  cy.screenshot("partnership_manager_reports");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [11/11 | 100%] - Verified Partnership Manager Reports successfully!\n");

  });
});
