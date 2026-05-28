// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - therapist_workflow", () => {
  it("opens and verifies screen therapist_workflow", () => {
    cy.loginAsRole("therapist");

  cy.visitWithSemantics("/allied/therapist-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("therapist compliance workflow-screen").should("be.visible");
  cy.getCy("therapist compliance workflow-title").should("be.visible");
  cy.getCy("therapist compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("therapist_workflow");

  });
});
