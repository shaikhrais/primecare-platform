// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_tasks", () => {
  it("opens and verifies screen rn_tasks", () => {
    cy.loginAsRole("rn");

  cy.visitWithSemantics("/rn/rn-tasks");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rntasks-screen").should("be.visible");
  cy.getCy("rntasks-title").should("be.visible");
  cy.getCy("rntasks-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_tasks");

  });
});
