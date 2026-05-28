// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - head_of_bus_dev_workflow", () => {
  it("opens and verifies screen head_of_bus_dev_workflow", () => {
    cy.loginAsRole("bus_dev");

  cy.visitWithSemantics("/management/head-of-bus-dev-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofbusdevworkflow-screen").should("be.visible");
  cy.getCy("headofbusdevworkflow-title").should("be.visible");
  cy.getCy("headofbusdevworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("head_of_bus_dev_workflow");

  });
});
