// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_dashboard", () => {
  it("opens and verifies screen coo_dashboard", () => {
    cy.loginAsRole("coo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/coo-dashboard (CooDashboardScreen)...");
  cy.visitWithSemantics("/executive/coo-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CooDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coodashboard-screen").should("be.visible");
  cy.getCy("coodashboard-title").should("be.visible");
  cy.getCy("coodashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CooDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("coo_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified CooDashboardScreen successfully!\n");

  });
});
