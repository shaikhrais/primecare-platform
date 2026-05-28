// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - claims_processing", () => {
  it("opens and verifies screen claims_processing", () => {
    cy.loginAsRole("admin");

  cy.visitWithSemantics("/staff/claims-processing");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("claimsprocessing-screen").should("be.visible");
  cy.getCy("claimsprocessing-title").should("be.visible");
  cy.getCy("claimsprocessing-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("claims_processing");

  });
});
