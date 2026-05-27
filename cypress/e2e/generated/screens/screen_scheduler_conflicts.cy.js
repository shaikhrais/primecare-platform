// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_conflicts", () => {
  it("opens and verifies screen scheduler_conflicts", () => {
    cy.loginAsRole("scheduler");

  cy.visit("/staff/scheduler-conflicts");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulerconflicts-screen").should("be.visible");
  cy.getCy("schedulerconflicts-title").should("be.visible");
  cy.getCy("schedulerconflicts-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_conflicts");

  });
});
