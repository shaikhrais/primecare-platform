// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - franchise_sales", () => {
  it("tests all screens for role franchise_sales", () => {
    cy.loginAsRole("franchise_sales");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Navigating to /management/franchise-sales-manager-dashboard (FranchiseSalesManagerDashboardScreen)...");
  cy.visitWithSemantics("/management/franchise-sales-manager-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Checking shell & content for FranchiseSalesManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagerdashboard-screen").should("be.visible");
  cy.getCy("franchisesalesmanagerdashboard-title").should("be.visible");
  cy.getCy("franchisesalesmanagerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Saving screenshot for FranchiseSalesManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Verified FranchiseSalesManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Navigating to /executive/franchise-sales-analytics (Franchise Sales Manager Analytics)...");
  cy.visitWithSemantics("/executive/franchise-sales-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Checking shell & content for Franchise Sales Manager Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchise sales manager analytics-screen").should("be.visible");
  cy.getCy("franchise sales manager analytics-title").should("be.visible");
  cy.getCy("franchise sales manager analytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Saving screenshot for Franchise Sales Manager Analytics...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Verified Franchise Sales Manager Analytics successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Navigating to /executive/franchise-sales-workflow (Franchise Sales Manager Compliance Workflow)...");
  cy.visitWithSemantics("/executive/franchise-sales-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Checking shell & content for Franchise Sales Manager Compliance Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchise sales manager compliance workflow-screen").should("be.visible");
  cy.getCy("franchise sales manager compliance workflow-title").should("be.visible");
  cy.getCy("franchise sales manager compliance workflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Saving screenshot for Franchise Sales Manager Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Verified Franchise Sales Manager Compliance Workflow successfully!\n");

  });
});
