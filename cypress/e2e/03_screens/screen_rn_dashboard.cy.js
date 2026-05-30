// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_dashboard", () => {
  it("opens and verifies screen rn_dashboard", () => {
    cy.loginAsRole("rn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rn/dashboard (RnDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RnDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rndashboard-screen").should("be.visible");
  cy.getCy("rndashboard-title").should("be.visible");
  cy.getCy("rndashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RnDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified RnDashboardScreen successfully!\n");

  });
});
