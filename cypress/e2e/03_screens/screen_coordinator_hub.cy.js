// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coordinator_hub", () => {
  it("opens and verifies screen coordinator_hub", () => {
    cy.loginAsRole("scheduler");

  cy.visitWithSemantics("/staff/coordinator-hub");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coordinatorhub-screen").should("be.visible");
  cy.getCy("coordinatorhub-title").should("be.visible");
  cy.getCy("coordinatorhub-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coordinator_hub");

  });
});
