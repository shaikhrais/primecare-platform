// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_analytics", () => {
  it("opens and verifies screen psw_analytics", () => {
    cy.loginAsRole("psw");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/psw/psw-analytics (PswAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/psw-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PswAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswanalytics-screen").should("be.visible");
  cy.getCy("pswanalytics-title").should("be.visible");
  cy.getCy("pswanalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PswAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified PswAnalyticsScreen successfully!\n");

  });
});
