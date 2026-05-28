// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - governance_officer_workflow", () => {
  it("opens and verifies screen governance_officer_workflow", () => {
    cy.loginAsRole("governance");

  cy.visitWithSemantics("/management/governance-officer-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficerworkflow-screen").should("be.visible");
  cy.getCy("governanceofficerworkflow-title").should("be.visible");
  cy.getCy("governanceofficerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_officer_workflow");

  });
});
