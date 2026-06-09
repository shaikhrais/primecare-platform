// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - social_worker_analytics", () => {
  it("opens and verifies screen social_worker_analytics", () => {
    cy.loginAsRole("social_worker");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/social_worker/analytics (SocialWorkerAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/social_worker/analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SocialWorkerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialworkeranalytics-screen").should("be.visible");
  cy.getCy("socialworkeranalytics-title").should("be.visible");
  cy.getCy("socialworkeranalytics-content").should("be.visible");
  cy.getCy("socialworker-btn-add-assessment").should("be.visible");
  cy.getCy("socialworker-btn-schedule-appointment").should("be.visible");
  cy.getCy("socialworker-btn-log-communication").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SocialWorkerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("social_worker_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified SocialWorkerAnalyticsScreen successfully!\n");

  });
});
