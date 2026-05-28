// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - head_of_bus_dev_compliance", () => {
  it("opens and verifies screen head_of_bus_dev_compliance", () => {
    cy.loginAsRole("bus_dev");

  cy.visitWithSemantics("/management/head-of-bus-dev-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofbusdevcompliance-screen").should("be.visible");
  cy.getCy("headofbusdevcompliance-title").should("be.visible");
  cy.getCy("headofbusdevcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("head_of_bus_dev_compliance");

  });
});
