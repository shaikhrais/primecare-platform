// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - shift_tasks", () => {
  it("opens and verifies screen shift_tasks", () => {
    cy.loginAsRole("psw");

  cy.visit("/psw/shift-tasks");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shifttasks-screen").should("be.visible");
  cy.getCy("shifttasks-title").should("be.visible");
  cy.getCy("shifttasks-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("shift_tasks");

  });
});
