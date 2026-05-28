// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physiotherapist_compliance", () => {
  it("opens and verifies screen physiotherapist_compliance", () => {
    cy.loginAsRole("physio");

  cy.visitWithSemantics("/common/physiotherapist-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistcompliance-screen").should("be.visible");
  cy.getCy("physiotherapistcompliance-title").should("be.visible");
  cy.getCy("physiotherapistcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_compliance");

  });
});
