// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_analytics", () => {
  it("opens and verifies screen scheduler_analytics", () => {
    cy.loginAsRole("scheduler");

  cy.visit("/staff/scheduler-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scheduleranalytics-screen").should("be.visible");
  cy.getCy("scheduleranalytics-title").should("be.visible");
  cy.getCy("scheduleranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_analytics");

  });
});
