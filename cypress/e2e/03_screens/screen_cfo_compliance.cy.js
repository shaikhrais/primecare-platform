// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_compliance", () => {
  it("opens and verifies screen cfo_compliance", () => {
    cy.loginAsRole("cfo");

  cy.visitWithSemantics("/executive/cfo-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfocompliance-screen").should("be.visible");
  cy.getCy("cfocompliance-title").should("be.visible");
  cy.getCy("cfocompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_compliance");

  });
});
