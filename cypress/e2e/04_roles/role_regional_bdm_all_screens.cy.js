// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - regional_bdm", () => {
  it("tests all screens for role regional_bdm", () => {
    cy.loginAsRole("regional_bdm");


  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Navigating to /offices/business_development/roles/regional_bdm/dashboard (RegionalBdmDashboardScreen)...");
  cy.visitWithSemantics("/offices/business_development/roles/regional_bdm/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Checking shell & content for RegionalBdmDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("regionalbdmdashboard-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("regionalbdmdashboard-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("regionalbdmdashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Saving screenshot for RegionalBdmDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("regional_bdm_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Verified RegionalBdmDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Navigating to /management/regional-bdm-analytics (RegionalBdmAnalyticsScreen)...");
  cy.visitWithSemantics("/management/regional-bdm-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Checking shell & content for RegionalBdmAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("regionalbdmanalytics-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("regionalbdmanalytics-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("regionalbdmanalytics-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Saving screenshot for RegionalBdmAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("regional_bdm_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Verified RegionalBdmAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Navigating to /management/regional-bdm-compliance (RegionalBdmComplianceScreen)...");
  cy.visitWithSemantics("/management/regional-bdm-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Checking shell & content for RegionalBdmComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("regionalbdmcompliance-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("regionalbdmcompliance-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("regionalbdmcompliance-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Saving screenshot for RegionalBdmComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("regional_bdm_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Verified RegionalBdmComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Navigating to /management/regional-bdm-workflow (RegionalBdmWorkflowScreen)...");
  cy.visitWithSemantics("/management/regional-bdm-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Checking shell & content for RegionalBdmWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("regionalbdmworkflow-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("regionalbdmworkflow-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("regionalbdmworkflow-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Saving screenshot for RegionalBdmWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("regional_bdm_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Verified RegionalBdmWorkflowScreen successfully!\n");

  });
});
