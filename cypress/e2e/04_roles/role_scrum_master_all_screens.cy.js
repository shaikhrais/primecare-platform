// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - scrum_master", () => {
  it("tests all screens for role scrum_master", () => {
    cy.loginAsRole("scrum_master");


  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Navigating to /management/scrum-master-dashboard (ScrumMasterDashboardScreen)...");
  cy.visitWithSemantics("/management/scrum-master-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Checking shell & content for ScrumMasterDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scrummasterdashboard-screen").should("be.visible");
  cy.getCy("scrummasterdashboard-title").should("be.visible");
  cy.getCy("scrummasterdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Saving screenshot for ScrumMasterDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("scrum_master_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Verified ScrumMasterDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Navigating to /management/scrum-master-analytics (ScrumMasterAnalyticsScreen)...");
  cy.visitWithSemantics("/management/scrum-master-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Checking shell & content for ScrumMasterAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scrummasteranalytics-screen").should("be.visible");
  cy.getCy("scrummasteranalytics-title").should("be.visible");
  cy.getCy("scrummasteranalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Saving screenshot for ScrumMasterAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("scrum_master_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Verified ScrumMasterAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Navigating to /management/scrum-master-compliance (ScrumMasterComplianceScreen)...");
  cy.visitWithSemantics("/management/scrum-master-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Checking shell & content for ScrumMasterComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scrummastercompliance-screen").should("be.visible");
  cy.getCy("scrummastercompliance-title").should("be.visible");
  cy.getCy("scrummastercompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Saving screenshot for ScrumMasterComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("scrum_master_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Verified ScrumMasterComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Navigating to /management/scrum-master-workflow (ScrumMasterWorkflowScreen)...");
  cy.visitWithSemantics("/management/scrum-master-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Checking shell & content for ScrumMasterWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scrummasterworkflow-screen").should("be.visible");
  cy.getCy("scrummasterworkflow-title").should("be.visible");
  cy.getCy("scrummasterworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Saving screenshot for ScrumMasterWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("scrum_master_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Verified ScrumMasterWorkflowScreen successfully!\n");

  });
});
