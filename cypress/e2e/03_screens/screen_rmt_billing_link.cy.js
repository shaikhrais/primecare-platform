// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rmt_billing_link", () => {
  it("opens and verifies screen rmt_billing_link", () => {
    cy.loginAsRole("rmt");

  cy.visit("/allied/rmt-billing-link");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtbillinglink-screen").should("be.visible");
  cy.getCy("rmtbillinglink-title").should("be.visible");
  cy.getCy("rmtbillinglink-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_billing_link");

  });
});
