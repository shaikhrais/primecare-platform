// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - system_verification_analytics", () => {
  it("opens and verifies screen system_verification_analytics", () => {
    cy.loginAsRole("system_verification");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/system-verification-analytics (SystemVerificationAnalyticsScreen)...");
  cy.visitWithSemantics("/common/system-verification-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SystemVerificationAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemverificationanalytics-screen").should("be.visible");
  cy.getCy("systemverificationanalytics-title").should("be.visible");
  cy.getCy("systemverificationanalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SystemVerificationAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("system_verification_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified SystemVerificationAnalyticsScreen successfully!\n");

  });
});
