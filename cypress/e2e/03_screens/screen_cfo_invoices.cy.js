// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_invoices", () => {
  it("opens and verifies screen cfo_invoices", () => {
    cy.loginAsRole("cfo");

  cy.visitWithSemantics("/executive/cfo-invoices");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoinvoices-screen").should("be.visible");
  cy.getCy("cfoinvoices-title").should("be.visible");
  cy.getCy("cfoinvoices-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_invoices");

  });
});
