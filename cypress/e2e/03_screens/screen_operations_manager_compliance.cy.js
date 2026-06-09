// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - operations_manager_compliance", () => {
  it("opens and verifies screen operations_manager_compliance", () => {
    cy.loginAsRole("ops_manager");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/operations-manager-compliance (OperationsManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/operations-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for OperationsManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanagercompliance-screen").should("be.visible");
  cy.getCy("operationsmanagercompliance-title").should("be.visible");
  cy.getCy("operationsmanagercompliance-content").should("be.visible");
  cy.getCy("operations-compliance-status-card").should("be.visible");
  cy.getCy("operations-audit-log-table").should("be.visible");
  cy.getCy("operations-performance-metrics-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for OperationsManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("operations_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified OperationsManagerComplianceScreen successfully!\n");

  });
});
