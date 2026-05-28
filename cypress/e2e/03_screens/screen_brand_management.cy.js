// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - brand_management", () => {
  it("opens and verifies screen brand_management", () => {
    cy.loginAsRole("marketing");

  cy.visitWithSemantics("/management/brand-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("brandmanagement-screen").should("be.visible");
  cy.getCy("brandmanagement-title").should("be.visible");
  cy.getCy("brandmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("brand_management");

  });
});
