// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_profitability", () => {
  it("opens and verifies screen cfo_profitability", () => {
    cy.loginAsRole("cfo");

  cy.visit("/executive/cfo-profitability");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoprofitability-screen").should("be.visible");
  cy.getCy("cfoprofitability-title").should("be.visible");
  cy.getCy("cfoprofitability-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_profitability");

  });
});
