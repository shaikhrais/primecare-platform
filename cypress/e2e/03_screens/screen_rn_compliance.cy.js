// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_compliance", () => {
  it("opens and verifies screen rn_compliance", () => {
    cy.loginAsRole("rn");

  cy.visitWithSemantics("/rn/rn-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rncompliance-screen").should("be.visible");
  cy.getCy("rncompliance-title").should("be.visible");
  cy.getCy("rncompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_compliance");

  });
});
