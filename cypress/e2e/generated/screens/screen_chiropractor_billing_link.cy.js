// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractor_billing_link", () => {
  it("opens and verifies screen chiropractor_billing_link", () => {
    cy.loginAsRole("chiropractor");

  cy.visit("/allied/chiropractor-billing-link");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorbillinglink-screen").should("be.visible");
  cy.getCy("chiropractorbillinglink-title").should("be.visible");
  cy.getCy("chiropractorbillinglink-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_billing_link");

  });
});
