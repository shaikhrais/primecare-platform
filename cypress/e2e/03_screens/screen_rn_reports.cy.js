// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_reports", () => {
  it("opens and verifies screen rn_reports", () => {
    cy.loginAsRole("rn");

  cy.visitWithSemantics("/rn/rn-reports");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnreports-screen").should("be.visible");
  cy.getCy("rnreports-title").should("be.visible");
  cy.getCy("rnreports-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_reports");

  });
});
