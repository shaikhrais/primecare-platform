// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_lead", () => {
  it("opens and verifies screen franchise_lead", () => {
    cy.loginAsRole("bus_dev");

  cy.visitWithSemantics("/management/franchise-lead");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiselead-screen").should("be.visible");
  cy.getCy("franchiselead-title").should("be.visible");
  cy.getCy("franchiselead-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_lead");

  });
});
