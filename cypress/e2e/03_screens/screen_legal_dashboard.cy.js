// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - legal_dashboard", () => {
  it("opens and verifies screen legal_dashboard", () => {
    cy.loginAsRole("legal");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/legal/dashboard (LegalDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/legal/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for LegalDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("legaldashboard-screen").should("be.visible");
  cy.getCy("legaldashboard-title").should("be.visible");
  cy.getCy("legaldashboard-content").should("be.visible");
  cy.getCy("legal-dashboard-compliance-status").should("be.visible");
  cy.getCy("legal-dashboard-dispute-status").should("be.visible");
  cy.getCy("legal-dashboard-performance-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for LegalDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("legal_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified LegalDashboardScreen successfully!\n");

  });
});
