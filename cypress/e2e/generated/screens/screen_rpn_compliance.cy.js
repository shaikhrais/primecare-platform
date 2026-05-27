// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rpn_compliance", () => {
  it("opens and verifies screen rpn_compliance", () => {
    cy.loginAsRole("rpn");

  cy.visit("/rpn/rpn-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpncompliance-screen").should("be.visible");
  cy.getCy("rpncompliance-title").should("be.visible");
  cy.getCy("rpncompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_compliance");

  });
});
