// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scrum_master_analytics", () => {
  it("opens and verifies screen scrum_master_analytics", () => {
    cy.loginAsRole("scrum_master");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/scrum-master-analytics (ScrumMasterAnalyticsScreen)...");
  cy.visitWithSemantics("/management/scrum-master-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ScrumMasterAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scrummasteranalytics-screen").should("be.visible");
  cy.getCy("scrummasteranalytics-title").should("be.visible");
  cy.getCy("scrummasteranalytics-content").should("be.visible");
  cy.getCy("scrum-dashboard-btn-add-impediment").should("be.visible");
  cy.getCy("scrum-dashboard-btn-resolve-impediment").should("be.visible");
  cy.getCy("scrum-dashboard-btn-start-sprint-planning").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ScrumMasterAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("scrum_master_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified ScrumMasterAnalyticsScreen successfully!\n");

  });
});
