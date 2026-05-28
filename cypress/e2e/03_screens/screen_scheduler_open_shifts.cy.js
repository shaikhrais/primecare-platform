// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_open_shifts", () => {
  it("opens and verifies screen scheduler_open_shifts", () => {
    cy.loginAsRole("scheduler");

  cy.visitWithSemantics("/staff/scheduler-open-shifts");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scheduleropenshifts-screen").should("be.visible");
  cy.getCy("scheduleropenshifts-title").should("be.visible");
  cy.getCy("scheduleropenshifts-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_open_shifts");

  });
});
