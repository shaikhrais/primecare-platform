// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_workflow", () => {
  it("opens and verifies screen rn_workflow", () => {
    cy.loginAsRole("rn");

  cy.visit("/rn/rn-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnworkflow-screen").should("be.visible");
  cy.getCy("rnworkflow-title").should("be.visible");
  cy.getCy("rnworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_workflow");

  });
});
