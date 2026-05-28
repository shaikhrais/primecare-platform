// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rmt_reports", () => {
  it("opens and verifies screen rmt_reports", () => {
    cy.loginAsRole("rmt");

  cy.visitWithSemantics("/allied/rmt-reports");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtreports-screen").should("be.visible");
  cy.getCy("rmtreports-title").should("be.visible");
  cy.getCy("rmtreports-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_reports");

  });
});
