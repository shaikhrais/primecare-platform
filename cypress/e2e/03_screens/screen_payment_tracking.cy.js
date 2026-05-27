// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - payment_tracking", () => {
  it("opens and verifies screen payment_tracking", () => {
    cy.loginAsRole("admin");

  cy.visit("/staff/payment-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("paymenttracking-screen").should("be.visible");
  cy.getCy("paymenttracking-title").should("be.visible");
  cy.getCy("paymenttracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("payment_tracking");

  });
});
