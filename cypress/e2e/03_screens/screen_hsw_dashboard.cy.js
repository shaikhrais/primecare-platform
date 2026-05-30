// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hsw_dashboard", () => {
  it("opens and verifies screen hsw_dashboard", () => {
    cy.loginAsRole("hsw");

  cy.task("log", "⏳ PROGRESS: - Navigating to /clinical/hsw-dashboard (HswDashboardScreen)...");
  cy.visitWithSemantics("/clinical/hsw-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HswDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hswdashboard-screen").should("be.visible");
  cy.getCy("hswdashboard-title").should("be.visible");
  cy.getCy("hswdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HswDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("hsw_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified HswDashboardScreen successfully!\n");

  });
});
