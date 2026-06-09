// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - portal_analytics", () => {
  it("opens and verifies screen portal_analytics", () => {
    cy.loginAsRole("portal");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/portal-analytics (PortalAnalyticsScreen)...");
  cy.visitWithSemantics("/common/portal-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PortalAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("portalanalytics-screen").should("be.visible");
  cy.getCy("portalanalytics-title").should("be.visible");
  cy.getCy("portalanalytics-content").should("be.visible");
  cy.getCy("portal-analytics-btn-execute-sweep").should("be.visible");
  cy.getCy("portal-analytics-btn-refresh-logs").should("be.visible");
  cy.getCy("portal-analytics-btn-trigger-manual-sweep").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PortalAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("portal_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified PortalAnalyticsScreen successfully!\n");

  });
});
