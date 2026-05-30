// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_director_analytics", () => {
  it("opens and verifies screen hr_director_analytics", () => {
    cy.loginAsRole("hr_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/hr-director-analytics (HrDirectorAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/hr-director-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HrDirectorAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectoranalytics-screen").should("be.visible");
  cy.getCy("hrdirectoranalytics-title").should("be.visible");
  cy.getCy("hrdirectoranalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HrDirectorAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_director_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified HrDirectorAnalyticsScreen successfully!\n");

  });
});
