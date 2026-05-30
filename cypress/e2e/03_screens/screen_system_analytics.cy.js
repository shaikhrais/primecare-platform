// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - system_analytics", () => {
  it("opens and verifies screen system_analytics", () => {
    cy.loginAsRole("system_verification");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/system-analytics (SystemAnalyticsScreen)...");
  cy.visitWithSemantics("/common/system-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SystemAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemanalytics-screen").should("be.visible");
  cy.getCy("systemanalytics-title").should("be.visible");
  cy.getCy("systemanalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SystemAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("system_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified SystemAnalyticsScreen successfully!\n");

  });
});
