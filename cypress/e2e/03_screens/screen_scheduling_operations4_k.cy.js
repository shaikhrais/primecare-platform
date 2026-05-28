// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduling_operations4_k", () => {
  it("opens and verifies screen scheduling_operations4_k", () => {
    cy.loginAsRole("scheduler");

  cy.visitWithSemantics("/staff/scheduling-operations4-k");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulingoperations4k-screen").should("be.visible");
  cy.getCy("schedulingoperations4k-title").should("be.visible");
  cy.getCy("schedulingoperations4k-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduling_operations4_k");

  });
});
