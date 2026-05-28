// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physiotherapist_billing_link", () => {
  it("opens and verifies screen physiotherapist_billing_link", () => {
    cy.loginAsRole("physio");

  cy.visitWithSemantics("/allied/physiotherapist-billing-link");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistbillinglink-screen").should("be.visible");
  cy.getCy("physiotherapistbillinglink-title").should("be.visible");
  cy.getCy("physiotherapistbillinglink-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_billing_link");

  });
});
