// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinical_operations4_k", () => {
  it("opens and verifies screen clinical_operations4_k", () => {
    cy.loginAsRole("clinical_director");

  cy.visitWithSemantics("/clinical/clinical-operations4-k");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaloperations4k-screen").should("be.visible");
  cy.getCy("clinicaloperations4k-title").should("be.visible");
  cy.getCy("clinicaloperations4k-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_operations4_k");

  });
});
