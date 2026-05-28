// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rpn_medications", () => {
  it("opens and verifies screen rpn_medications", () => {
    cy.loginAsRole("rpn");

  cy.visitWithSemantics("/rpn/rpn-medications");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnmedications-screen").should("be.visible");
  cy.getCy("rpnmedications-title").should("be.visible");
  cy.getCy("rpnmedications-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_medications");

  });
});
