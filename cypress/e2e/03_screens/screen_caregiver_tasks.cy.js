// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - caregiver_tasks", () => {
  it("opens and verifies screen caregiver_tasks", () => {
    cy.loginAsRole("caregiver");

  cy.visitWithSemantics("/psw/caregiver-tasks");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregivertasks-screen").should("be.visible");
  cy.getCy("caregivertasks-title").should("be.visible");
  cy.getCy("caregivertasks-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("caregiver_tasks");

  });
});
