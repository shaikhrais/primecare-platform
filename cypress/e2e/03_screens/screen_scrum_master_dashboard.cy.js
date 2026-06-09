// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scrum_master_dashboard", () => {
  it("opens and verifies screen scrum_master_dashboard", () => {
    cy.loginAsRole("scrum_master");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/scrum-master-dashboard (ScrumMasterDashboardScreen)...");
  cy.visitWithSemantics("/management/scrum-master-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ScrumMasterDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scrummasterdashboard-screen").should("be.visible");
  cy.getCy("scrummasterdashboard-title").should("be.visible");
  cy.getCy("scrummasterdashboard-content").should("be.visible");
  cy.getCy("scrum-dashboard-burndown-chart").should("be.visible");
  cy.getCy("scrum-dashboard-velocity-metric").should("be.visible");
  cy.getCy("scrum-dashboard-impediment-list").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ScrumMasterDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("scrum_master_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified ScrumMasterDashboardScreen successfully!\n");

  });
});
