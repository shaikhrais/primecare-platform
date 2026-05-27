// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - billing", () => {
  it("opens and verifies screen billing", () => {
    cy.loginAsRole("patient");

  cy.visit("/common/billing");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billing-screen").should("be.visible");
  cy.getCy("billing-title").should("be.visible");
  cy.getCy("billing-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("billing");

  });
});
