// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_dashboard", () => {
  it("opens and verifies screen scheduler_dashboard", () => {
    cy.loginAsRole("scheduler");

  cy.visitWithSemantics("/staff/scheduler-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulerdashboard-screen").should("be.visible");
  cy.getCy("schedulerdashboard-title").should("be.visible");
  cy.getCy("schedulerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_dashboard");

  });
});
