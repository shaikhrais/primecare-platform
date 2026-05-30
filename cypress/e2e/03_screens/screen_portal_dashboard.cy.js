// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - portal_dashboard", () => {
  it("opens and verifies screen portal_dashboard", () => {
    cy.loginAsRole("portal");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/portal-dashboard (PortalDashboardScreen)...");
  cy.visitWithSemantics("/common/portal-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PortalDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("portaldashboard-screen").should("be.visible");
  cy.getCy("portaldashboard-title").should("be.visible");
  cy.getCy("portaldashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PortalDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("portal_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified PortalDashboardScreen successfully!\n");

  });
});
