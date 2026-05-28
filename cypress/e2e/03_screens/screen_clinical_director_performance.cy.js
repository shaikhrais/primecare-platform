// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinical_director_performance", () => {
  it("opens and verifies screen clinical_director_performance", () => {
    cy.loginAsRole("clinical_director");

  cy.visitWithSemantics("/clinical/clinical-director-performance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorperformance-screen").should("be.visible");
  cy.getCy("clinicaldirectorperformance-title").should("be.visible");
  cy.getCy("clinicaldirectorperformance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_director_performance");

  });
});
