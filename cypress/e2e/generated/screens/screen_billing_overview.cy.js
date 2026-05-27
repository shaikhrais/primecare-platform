// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - billing_overview", () => {
  it("opens and verifies screen billing_overview", () => {
    cy.loginAsRole("family");

  cy.visit("/common/billing-overview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingoverview-screen").should("be.visible");
  cy.getCy("billingoverview-title").should("be.visible");
  cy.getCy("billingoverview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("billing_overview");

  });
});
