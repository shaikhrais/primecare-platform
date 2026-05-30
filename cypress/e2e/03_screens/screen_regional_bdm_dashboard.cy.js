// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_bdm_dashboard", () => {
  it("opens and verifies screen regional_bdm_dashboard", () => {
    cy.loginAsRole("regional_bdm");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/regional-bdm-dashboard (RegionalBdmDashboardScreen)...");
  cy.visitWithSemantics("/management/regional-bdm-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RegionalBdmDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmdashboard-screen").should("be.visible");
  cy.getCy("regionalbdmdashboard-title").should("be.visible");
  cy.getCy("regionalbdmdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RegionalBdmDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("regional_bdm_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified RegionalBdmDashboardScreen successfully!\n");

  });
});
