// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_compliance", () => {
  it("opens and verifies screen scheduler_compliance", () => {
    cy.loginAsRole("scheduler");

  cy.visit("/staff/scheduler-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulercompliance-screen").should("be.visible");
  cy.getCy("schedulercompliance-title").should("be.visible");
  cy.getCy("schedulercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_compliance");

  });
});
