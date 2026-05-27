// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - conflict_resolution", () => {
  it("opens and verifies screen conflict_resolution", () => {
    cy.loginAsRole("scheduler");

  cy.visit("/staff/conflict-resolution");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("conflictresolution-screen").should("be.visible");
  cy.getCy("conflictresolution-title").should("be.visible");
  cy.getCy("conflictresolution-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("conflict_resolution");

  });
});
