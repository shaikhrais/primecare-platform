// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_dashboard", () => {
  it("opens and verifies screen cfo_dashboard", () => {
    cy.loginAsRole("cfo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/cfo/dashboard (CfoDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CfoDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfodashboard-screen").should("be.visible");
  cy.getCy("cfodashboard-title").should("be.visible");
  cy.getCy("cfodashboard-content").should("be.visible");
  cy.getCy("cfo-dashboard-cash-balance").should("be.visible");
  cy.getCy("cfo-dashboard-growth-rate").should("be.visible");
  cy.getCy("cfo-dashboard-expense-buffer").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CfoDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified CfoDashboardScreen successfully!\n");

  });
});
