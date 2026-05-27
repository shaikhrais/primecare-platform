// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - head_of_bus_dev_dashboard", () => {
  it("opens and verifies screen head_of_bus_dev_dashboard", () => {
    cy.loginAsRole("bus_dev");

  cy.visit("/management/head-of-bus-dev-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofbusdevdashboard-screen").should("be.visible");
  cy.getCy("headofbusdevdashboard-title").should("be.visible");
  cy.getCy("headofbusdevdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("head_of_bus_dev_dashboard");

  });
});
