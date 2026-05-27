// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rmt_workflow", () => {
  it("opens and verifies screen rmt_workflow", () => {
    cy.loginAsRole("rmt");

  cy.visit("/allied/rmt-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtworkflow-screen").should("be.visible");
  cy.getCy("rmtworkflow-title").should("be.visible");
  cy.getCy("rmtworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_workflow");

  });
});
