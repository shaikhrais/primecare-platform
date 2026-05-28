// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - head_of_bus_dev_analytics", () => {
  it("opens and verifies screen head_of_bus_dev_analytics", () => {
    cy.loginAsRole("bus_dev");

  cy.visitWithSemantics("/management/head-of-bus-dev-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofbusdevanalytics-screen").should("be.visible");
  cy.getCy("headofbusdevanalytics-title").should("be.visible");
  cy.getCy("headofbusdevanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("head_of_bus_dev_analytics");

  });
});
