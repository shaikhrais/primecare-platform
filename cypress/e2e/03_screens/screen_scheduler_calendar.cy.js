// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_calendar", () => {
  it("opens and verifies screen scheduler_calendar", () => {
    cy.loginAsRole("scheduler");

  cy.visitWithSemantics("/staff/scheduler-calendar");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulercalendar-screen").should("be.visible");
  cy.getCy("schedulercalendar-title").should("be.visible");
  cy.getCy("schedulercalendar-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_calendar");

  });
});
