// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - local_marketing", () => {
  it("tests all screens for role local_marketing", () => {
    cy.loginAsRole("local_marketing");


  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/11 | 9%] - Navigating to /offices/marketing/roles/local_marketing_manager/dashboard (LocalMarketingManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/marketing/roles/local_marketing_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/11 | 9%] - Checking shell & content for LocalMarketingManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagerdashboard-screen").should("be.visible");
  cy.getCy("localmarketingmanagerdashboard-title").should("be.visible");
  cy.getCy("localmarketingmanagerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/11 | 9%] - Saving screenshot for LocalMarketingManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/11 | 9%] - Verified LocalMarketingManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/11 | 18%] - Navigating to /management/local-marketing-manager-analytics (LocalMarketingManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/local-marketing-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/11 | 18%] - Checking shell & content for LocalMarketingManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanageranalytics-screen").should("be.visible");
  cy.getCy("localmarketingmanageranalytics-title").should("be.visible");
  cy.getCy("localmarketingmanageranalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/11 | 18%] - Saving screenshot for LocalMarketingManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/11 | 18%] - Verified LocalMarketingManagerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/11 | 27%] - Navigating to /management/local-marketing-manager-compliance (LocalMarketingManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/local-marketing-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/11 | 27%] - Checking shell & content for LocalMarketingManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagercompliance-screen").should("be.visible");
  cy.getCy("localmarketingmanagercompliance-title").should("be.visible");
  cy.getCy("localmarketingmanagercompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/11 | 27%] - Saving screenshot for LocalMarketingManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/11 | 27%] - Verified LocalMarketingManagerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/11 | 36%] - Navigating to /management/local-marketing-manager-workflow (LocalMarketingManagerWorkflowScreen)...");
  cy.visitWithSemantics("/management/local-marketing-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/11 | 36%] - Checking shell & content for LocalMarketingManagerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagerworkflow-screen").should("be.visible");
  cy.getCy("localmarketingmanagerworkflow-title").should("be.visible");
  cy.getCy("localmarketingmanagerworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/11 | 36%] - Saving screenshot for LocalMarketingManagerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/11 | 36%] - Verified LocalMarketingManagerWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/11 | 45%] - Navigating to None (Local Marketing Manager Assets)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/11 | 45%] - Checking shell & content for Local Marketing Manager Assets...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("local marketing manager assets-screen").should("be.visible");
  cy.getCy("local marketing manager assets-title").should("be.visible");
  cy.getCy("local marketing manager assets-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/11 | 45%] - Saving screenshot for Local Marketing Manager Assets...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_assets");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/11 | 45%] - Verified Local Marketing Manager Assets successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/11 | 54%] - Navigating to None (Local Marketing Manager Budget)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/11 | 54%] - Checking shell & content for Local Marketing Manager Budget...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("local marketing manager budget-screen").should("be.visible");
  cy.getCy("local marketing manager budget-title").should("be.visible");
  cy.getCy("local marketing manager budget-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/11 | 54%] - Saving screenshot for Local Marketing Manager Budget...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_budget");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/11 | 54%] - Verified Local Marketing Manager Budget successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [7/11 | 63%] - Navigating to None (Local Marketing Manager Campaigns)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [7/11 | 63%] - Checking shell & content for Local Marketing Manager Campaigns...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("local marketing manager campaigns-screen").should("be.visible");
  cy.getCy("local marketing manager campaigns-title").should("be.visible");
  cy.getCy("local marketing manager campaigns-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [7/11 | 63%] - Saving screenshot for Local Marketing Manager Campaigns...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_campaigns");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [7/11 | 63%] - Verified Local Marketing Manager Campaigns successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [8/11 | 72%] - Navigating to None (Local Marketing Manager Content Calendar)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [8/11 | 72%] - Checking shell & content for Local Marketing Manager Content Calendar...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("local marketing manager content calendar-screen").should("be.visible");
  cy.getCy("local marketing manager content calendar-title").should("be.visible");
  cy.getCy("local marketing manager content calendar-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [8/11 | 72%] - Saving screenshot for Local Marketing Manager Content Calendar...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_content_calendar");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [8/11 | 72%] - Verified Local Marketing Manager Content Calendar successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [9/11 | 81%] - Navigating to None (Local Marketing Manager Events)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [9/11 | 81%] - Checking shell & content for Local Marketing Manager Events...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("local marketing manager events-screen").should("be.visible");
  cy.getCy("local marketing manager events-title").should("be.visible");
  cy.getCy("local marketing manager events-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [9/11 | 81%] - Saving screenshot for Local Marketing Manager Events...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_events");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [9/11 | 81%] - Verified Local Marketing Manager Events successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [10/11 | 90%] - Navigating to None (Local Marketing Manager Leads)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [10/11 | 90%] - Checking shell & content for Local Marketing Manager Leads...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("local marketing manager leads-screen").should("be.visible");
  cy.getCy("local marketing manager leads-title").should("be.visible");
  cy.getCy("local marketing manager leads-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [10/11 | 90%] - Saving screenshot for Local Marketing Manager Leads...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_leads");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [10/11 | 90%] - Verified Local Marketing Manager Leads successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [11/11 | 100%] - Navigating to None (Local Marketing Manager Reports)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [11/11 | 100%] - Checking shell & content for Local Marketing Manager Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("local marketing manager reports-screen").should("be.visible");
  cy.getCy("local marketing manager reports-title").should("be.visible");
  cy.getCy("local marketing manager reports-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [11/11 | 100%] - Saving screenshot for Local Marketing Manager Reports...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_reports");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [11/11 | 100%] - Verified Local Marketing Manager Reports successfully!\n");

  });
});
