// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - receptionist_workflow", () => {
  it("opens and verifies screen receptionist_workflow", () => {
    cy.loginAsRole("admin");

  cy.visitWithSemantics("/staff/receptionist-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistworkflow-screen").should("be.visible");
  cy.getCy("receptionistworkflow-title").should("be.visible");
  cy.getCy("receptionistworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("receptionist_workflow");

  });
});
