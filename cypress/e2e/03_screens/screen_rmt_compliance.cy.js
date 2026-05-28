// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rmt_compliance", () => {
  it("opens and verifies screen rmt_compliance", () => {
    cy.loginAsRole("rmt");

  cy.visitWithSemantics("/allied/rmt-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtcompliance-screen").should("be.visible");
  cy.getCy("rmtcompliance-title").should("be.visible");
  cy.getCy("rmtcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_compliance");

  });
});
