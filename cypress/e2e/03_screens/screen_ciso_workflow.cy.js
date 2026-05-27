// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - ciso_workflow", () => {
  it("opens and verifies screen ciso_workflow", () => {
    cy.loginAsRole("ciso");

  cy.visit("/executive/ciso-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cisoworkflow-screen").should("be.visible");
  cy.getCy("cisoworkflow-title").should("be.visible");
  cy.getCy("cisoworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("ciso_workflow");

  });
});
