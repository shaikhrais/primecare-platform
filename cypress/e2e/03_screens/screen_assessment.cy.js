// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - assessment", () => {
  it("opens and verifies screen assessment", () => {
    cy.loginAsRole("physio");

  cy.visitWithSemantics("/clinical/assessment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("assessment-screen").should("be.visible");
  cy.getCy("assessment-title").should("be.visible");
  cy.getCy("assessment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("assessment");

  });
});
