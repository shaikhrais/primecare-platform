// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coordinator_dispatch_map", () => {
  it("opens and verifies screen coordinator_dispatch_map", () => {
    cy.loginAsRole("scheduler");

  cy.visit("/staff/coordinator-dispatch-map");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coordinatordispatchmap-screen").should("be.visible");
  cy.getCy("coordinatordispatchmap-title").should("be.visible");
  cy.getCy("coordinatordispatchmap-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coordinator_dispatch_map");

  });
});
