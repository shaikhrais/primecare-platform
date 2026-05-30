// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - head_of_bus_dev_dashboard", () => {
  it("opens and verifies screen head_of_bus_dev_dashboard", () => {
    cy.loginAsRole("bus_dev");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/head-of-bus-dev-dashboard (HeadOfBusDevDashboardScreen)...");
  cy.visitWithSemantics("/management/head-of-bus-dev-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HeadOfBusDevDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofbusdevdashboard-screen").should("be.visible");
  cy.getCy("headofbusdevdashboard-title").should("be.visible");
  cy.getCy("headofbusdevdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HeadOfBusDevDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("head_of_bus_dev_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified HeadOfBusDevDashboardScreen successfully!\n");

  });
});
