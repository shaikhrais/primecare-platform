// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - revenue", () => {
  it("opens and verifies screen revenue", () => {
    cy.loginAsRole("cfo");

  cy.visitWithSemantics("/executive/revenue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("revenue-screen").should("be.visible");
  cy.getCy("revenue-title").should("be.visible");
  cy.getCy("revenue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("revenue");

  });
});
