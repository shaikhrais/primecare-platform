// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractor_analytics", () => {
  it("opens and verifies screen chiropractor_analytics", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/chiropractor/analytics (ChiropractorAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ChiropractorAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractoranalytics-screen").should("be.visible");
  cy.getCy("chiropractoranalytics-title").should("be.visible");
  cy.getCy("chiropractoranalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ChiropractorAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified ChiropractorAnalyticsScreen successfully!\n");

  });
});
