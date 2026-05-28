// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_coordinator_booking", () => {
  it("opens and verifies screen intake_coordinator_booking", () => {
    cy.loginAsRole("volunteer_coordinator");

  cy.visitWithSemantics("/executive/intake-coordinator-booking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorbooking-screen").should("be.visible");
  cy.getCy("intakecoordinatorbooking-title").should("be.visible");
  cy.getCy("intakecoordinatorbooking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_booking");

  });
});
