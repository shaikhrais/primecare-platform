// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - nursing_task", () => {
  it("opens and verifies screen nursing_task", () => {
    cy.loginAsRole("rpn");

  cy.visit("/clinical/nursing-task");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("nursingtask-screen").should("be.visible");
  cy.getCy("nursingtask-title").should("be.visible");
  cy.getCy("nursingtask-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("nursing_task");

  });
});
