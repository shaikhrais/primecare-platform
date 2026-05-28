// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - invoice_management", () => {
  it("opens and verifies screen invoice_management", () => {
    cy.loginAsRole("admin");

  cy.visitWithSemantics("/staff/invoice-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("invoicemanagement-screen").should("be.visible");
  cy.getCy("invoicemanagement-title").should("be.visible");
  cy.getCy("invoicemanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("invoice_management");

  });
});
