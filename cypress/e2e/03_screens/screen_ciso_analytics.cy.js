// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - ciso_analytics", () => {
  it("opens and verifies screen ciso_analytics", () => {
    cy.loginAsRole("ciso");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/ciso-analytics (CisoAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/ciso-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CisoAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cisoanalytics-screen").should("be.visible");
  cy.getCy("cisoanalytics-title").should("be.visible");
  cy.getCy("cisoanalytics-content").should("be.visible");
  cy.getCy("ciso-dashboard-btn-refresh").should("be.visible");
  cy.getCy("ciso-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("ciso-dashboard-btn-view-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CisoAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("ciso_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified CisoAnalyticsScreen successfully!\n");

  });
});
