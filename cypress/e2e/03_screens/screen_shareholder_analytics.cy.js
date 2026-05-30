// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - shareholder_analytics", () => {
  it("opens and verifies screen shareholder_analytics", () => {
    cy.loginAsRole("shareholder");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/shareholder-analytics (ShareholderAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/shareholder-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ShareholderAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shareholderanalytics-screen").should("be.visible");
  cy.getCy("shareholderanalytics-title").should("be.visible");
  cy.getCy("shareholderanalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ShareholderAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("shareholder_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified ShareholderAnalyticsScreen successfully!\n");

  });
});
