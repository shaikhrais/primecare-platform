// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - release_operations", () => {
  it("opens and verifies screen release_operations", () => {
    cy.loginAsRole("governance");

  cy.visitWithSemantics("/common/release-operations");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("releaseoperations-screen").should("be.visible");
  cy.getCy("releaseoperations-title").should("be.visible");
  cy.getCy("releaseoperations-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("release_operations");

  });
});
