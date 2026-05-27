// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_tasks", () => {
  it("opens and verifies screen psw_tasks", () => {
    cy.loginAsRole("psw");

  cy.visit("/psw/psw-tasks");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswtasks-screen").should("be.visible");
  cy.getCy("pswtasks-title").should("be.visible");
  cy.getCy("pswtasks-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_tasks");

  });
});
