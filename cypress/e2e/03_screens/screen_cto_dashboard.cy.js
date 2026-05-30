// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cto_dashboard", () => {
  it("opens and verifies screen cto_dashboard", () => {
    cy.loginAsRole("cto");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/cto-dashboard (CtoDashboardScreen)...");
  cy.visitWithSemantics("/executive/cto-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CtoDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctodashboard-screen").should("be.visible");
  cy.getCy("ctodashboard-title").should("be.visible");
  cy.getCy("ctodashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CtoDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("cto_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified CtoDashboardScreen successfully!\n");

  });
});
