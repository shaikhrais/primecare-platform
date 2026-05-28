// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - finance_director_compliance", () => {
  it("opens and verifies screen finance_director_compliance", () => {
    cy.loginAsRole("finance_director");

  cy.visitWithSemantics("/executive/finance-director-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectorcompliance-screen").should("be.visible");
  cy.getCy("financedirectorcompliance-title").should("be.visible");
  cy.getCy("financedirectorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("finance_director_compliance");

  });
});
