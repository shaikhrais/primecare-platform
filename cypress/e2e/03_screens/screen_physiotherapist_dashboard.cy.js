// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physiotherapist_dashboard", () => {
  it("opens and verifies screen physiotherapist_dashboard", () => {
    cy.loginAsRole("physio");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/physiotherapist/dashboard (PhysiotherapistDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PhysiotherapistDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistdashboard-screen").should("be.visible");
  cy.getCy("physiotherapistdashboard-title").should("be.visible");
  cy.getCy("physiotherapistdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PhysiotherapistDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified PhysiotherapistDashboardScreen successfully!\n");

  });
});
