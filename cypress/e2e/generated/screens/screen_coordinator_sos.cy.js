// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coordinator_sos", () => {
  it("opens and verifies screen coordinator_sos", () => {
    cy.loginAsRole("scheduler");

  cy.visit("/staff/coordinator-sos");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coordinatorsos-screen").should("be.visible");
  cy.getCy("coordinatorsos-title").should("be.visible");
  cy.getCy("coordinatorsos-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coordinator_sos");

  });
});
