// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_coordinator_new_client_intake", () => {
  it("opens and verifies screen intake_coordinator_new_client_intake", () => {
    cy.loginAsRole("volunteer_coordinator");

  cy.visitWithSemantics("/executive/intake-coordinator-new-client-intake");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatornewclientintake-screen").should("be.visible");
  cy.getCy("intakecoordinatornewclientintake-title").should("be.visible");
  cy.getCy("intakecoordinatornewclientintake-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_new_client_intake");

  });
});
