// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractor_reports", () => {
  it("opens and verifies screen chiropractor_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.visitWithSemantics("/allied/chiropractor-reports");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorreports-screen").should("be.visible");
  cy.getCy("chiropractorreports-title").should("be.visible");
  cy.getCy("chiropractorreports-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_reports");

  });
});
