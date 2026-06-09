// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - operations_manager_dashboard", () => {
  it("opens and verifies screen operations_manager_dashboard", () => {
    cy.loginAsRole("ops_manager");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/operations_manager/dashboard (OperationsManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/operations_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for OperationsManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanagerdashboard-screen").should("be.visible");
  cy.getCy("operationsmanagerdashboard-title").should("be.visible");
  cy.getCy("operationsmanagerdashboard-content").should("be.visible");
  cy.getCy("operations-dashboard-kpi").should("be.visible");
  cy.getCy("operations-dashboard-compliance").should("be.visible");
  cy.getCy("operations-dashboard-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for OperationsManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("operations_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified OperationsManagerDashboardScreen successfully!\n");

  });
});
