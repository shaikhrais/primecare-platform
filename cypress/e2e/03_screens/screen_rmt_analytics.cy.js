// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rmt_analytics", () => {
  it("opens and verifies screen rmt_analytics", () => {
    cy.loginAsRole("rmt");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rmt/analytics (RmtAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RmtAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtanalytics-screen").should("be.visible");
  cy.getCy("rmtanalytics-title").should("be.visible");
  cy.getCy("rmtanalytics-content").should("be.visible");
  cy.getCy("rmt-dashboard-btn-schedule-appointment").should("be.visible");
  cy.getCy("rmt-dashboard-btn-track-progress").should("be.visible");
  cy.getCy("rmt-dashboard-btn-performance-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RmtAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("rmt_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified RmtAnalyticsScreen successfully!\n");

  });
});
