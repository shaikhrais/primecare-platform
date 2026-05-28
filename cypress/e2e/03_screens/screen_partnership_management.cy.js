// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - partnership_management", () => {
  it("opens and verifies screen partnership_management", () => {
    cy.loginAsRole("bus_dev");

  cy.visitWithSemantics("/management/partnership-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagement-screen").should("be.visible");
  cy.getCy("partnershipmanagement-title").should("be.visible");
  cy.getCy("partnershipmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("partnership_management");

  });
});
