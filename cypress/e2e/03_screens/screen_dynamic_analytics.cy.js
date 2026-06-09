// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - dynamic_analytics", () => {
  it("opens and verifies screen dynamic_analytics", () => {
    cy.loginAsRole("dynamic");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/dynamic-analytics (DynamicScreenAnalyticsScreen)...");
  cy.visitWithSemantics("/common/dynamic-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for DynamicScreenAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dynamicanalytics-screen").should("be.visible");
  cy.getCy("dynamicanalytics-title").should("be.visible");
  cy.getCy("dynamicanalytics-content").should("be.visible");
  cy.getCy("dynamic-analytics-btn-refresh").should("be.visible");
  cy.getCy("dynamic-analytics-btn-customize").should("be.visible");
  cy.getCy("dynamic-analytics-btn-search").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for DynamicScreenAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("dynamic_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified DynamicScreenAnalyticsScreen successfully!\n");

  });
});
