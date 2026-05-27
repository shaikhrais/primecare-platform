// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - refund_management", () => {
  it("opens and verifies screen refund_management", () => {
    cy.loginAsRole("admin");

  cy.visit("/staff/refund-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("refundmanagement-screen").should("be.visible");
  cy.getCy("refundmanagement-title").should("be.visible");
  cy.getCy("refundmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("refund_management");

  });
});
