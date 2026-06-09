// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - head_of_bus_dev_analytics", () => {
  it("opens and verifies screen head_of_bus_dev_analytics", () => {
    cy.loginAsRole("bus_dev");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/head-of-bus-dev-analytics (HeadOfBusDevAnalyticsScreen)...");
  cy.visitWithSemantics("/management/head-of-bus-dev-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HeadOfBusDevAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofbusdevanalytics-screen").should("be.visible");
  cy.getCy("headofbusdevanalytics-title").should("be.visible");
  cy.getCy("headofbusdevanalytics-content").should("be.visible");
  cy.getCy("bd-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("bd-dashboard-btn-view-proposal").should("be.visible");
  cy.getCy("bd-dashboard-btn-negotiate-contract").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HeadOfBusDevAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("head_of_bus_dev_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified HeadOfBusDevAnalyticsScreen successfully!\n");

  });
});
