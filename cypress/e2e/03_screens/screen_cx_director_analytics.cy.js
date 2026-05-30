// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cx_director_analytics", () => {
  it("opens and verifies screen cx_director_analytics", () => {
    cy.loginAsRole("cx_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/cx-director-analytics (CxDirectorAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/cx-director-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CxDirectorAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectoranalytics-screen").should("be.visible");
  cy.getCy("cxdirectoranalytics-title").should("be.visible");
  cy.getCy("cxdirectoranalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CxDirectorAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("cx_director_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified CxDirectorAnalyticsScreen successfully!\n");

  });
});
