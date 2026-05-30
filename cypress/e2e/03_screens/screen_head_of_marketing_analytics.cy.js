// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - head_of_marketing_analytics", () => {
  it("opens and verifies screen head_of_marketing_analytics", () => {
    cy.loginAsRole("marketing");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/head-of-marketing-analytics (HeadOfMarketingAnalyticsScreen)...");
  cy.visitWithSemantics("/management/head-of-marketing-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HeadOfMarketingAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketinganalytics-screen").should("be.visible");
  cy.getCy("headofmarketinganalytics-title").should("be.visible");
  cy.getCy("headofmarketinganalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HeadOfMarketingAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("head_of_marketing_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified HeadOfMarketingAnalyticsScreen successfully!\n");

  });
});
