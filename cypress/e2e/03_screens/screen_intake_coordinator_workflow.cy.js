// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_coordinator_workflow", () => {
  it("opens and verifies screen intake_coordinator_workflow", () => {
    cy.loginAsRole("intake");

  cy.visitWithSemantics("/staff/intake-coordinator-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorworkflow-screen").should("be.visible");
  cy.getCy("intakecoordinatorworkflow-title").should("be.visible");
  cy.getCy("intakecoordinatorworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_workflow");

  });
});
