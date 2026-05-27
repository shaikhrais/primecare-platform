// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coordinator_waitlist", () => {
  it("opens and verifies screen coordinator_waitlist", () => {
    cy.loginAsRole("scheduler");

  cy.visit("/staff/coordinator-waitlist");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coordinatorwaitlist-screen").should("be.visible");
  cy.getCy("coordinatorwaitlist-title").should("be.visible");
  cy.getCy("coordinatorwaitlist-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coordinator_waitlist");

  });
});
