// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - shareholder_dashboard", () => {
  it("opens and verifies screen shareholder_dashboard", () => {
    cy.loginAsRole("shareholder");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/shareholder/dashboard (ShareholderDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/shareholder/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ShareholderDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shareholderdashboard-screen").should("be.visible");
  cy.getCy("shareholderdashboard-title").should("be.visible");
  cy.getCy("shareholderdashboard-content").should("be.visible");
  cy.getCy("shareholder-btn-export-logs").should("be.visible");
  cy.getCy("shareholder-btn-trigger-action").should("be.visible");
  cy.getCy("shareholder-btn-refresh-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ShareholderDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("shareholder_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified ShareholderDashboardScreen successfully!\n");

  });
});
