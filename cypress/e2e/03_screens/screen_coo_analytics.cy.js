// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_analytics", () => {
  it("opens and verifies screen coo_analytics", () => {
    cy.loginAsRole("coo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/coo-analytics (CooAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/coo-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CooAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cooanalytics-screen").should("be.visible");
  cy.getCy("cooanalytics-title").should("be.visible");
  cy.getCy("cooanalytics-content").should("be.visible");
  cy.getCy("coo-dashboard-refresh").should("be.visible");
  cy.getCy("coo-dashboard-view-report").should("be.visible");
  cy.getCy("coo-dashboard-export").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CooAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("coo_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified CooAnalyticsScreen successfully!\n");

  });
});
