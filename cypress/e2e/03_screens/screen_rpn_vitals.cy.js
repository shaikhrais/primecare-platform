// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rpn_vitals", () => {
  it("opens and verifies screen rpn_vitals", () => {
    cy.loginAsRole("rpn");

  cy.visitWithSemantics("/rpn/rpn-vitals");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnvitals-screen").should("be.visible");
  cy.getCy("rpnvitals-title").should("be.visible");
  cy.getCy("rpnvitals-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_vitals");

  });
});
