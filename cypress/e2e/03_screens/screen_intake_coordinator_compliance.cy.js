// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_coordinator_compliance", () => {
  it("opens and verifies screen intake_coordinator_compliance", () => {
    cy.loginAsRole("intake");

  cy.visitWithSemantics("/staff/intake-coordinator-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorcompliance-screen").should("be.visible");
  cy.getCy("intakecoordinatorcompliance-title").should("be.visible");
  cy.getCy("intakecoordinatorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_compliance");

  });
});
