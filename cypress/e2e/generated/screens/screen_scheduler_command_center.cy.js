// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_command_center", () => {
  it("opens and verifies screen scheduler_command_center", () => {
    cy.loginAsRole("scheduler");

  cy.visit("/staff/scheduler-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulercommandcenter-screen").should("be.visible");
  cy.getCy("schedulercommandcenter-title").should("be.visible");
  cy.getCy("schedulercommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_command_center");

  });
});
