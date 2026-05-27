// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rpn_tasks", () => {
  it("opens and verifies screen rpn_tasks", () => {
    cy.loginAsRole("rpn");

  cy.visit("/rpn/rpn-tasks");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpntasks-screen").should("be.visible");
  cy.getCy("rpntasks-title").should("be.visible");
  cy.getCy("rpntasks-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_tasks");

  });
});
