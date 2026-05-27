// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_workflow", () => {
  it("opens and verifies screen scheduler_workflow", () => {
    cy.loginAsRole("scheduler");

  cy.visit("/staff/scheduler-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulerworkflow-screen").should("be.visible");
  cy.getCy("schedulerworkflow-title").should("be.visible");
  cy.getCy("schedulerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_workflow");

  });
});
