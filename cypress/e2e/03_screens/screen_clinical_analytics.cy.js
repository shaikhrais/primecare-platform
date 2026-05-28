// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinical_analytics", () => {
  it("opens and verifies screen clinical_analytics", () => {
    cy.loginAsRole("clinical_director");

  cy.visitWithSemantics("/clinical/clinical-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalanalytics-screen").should("be.visible");
  cy.getCy("clinicalanalytics-title").should("be.visible");
  cy.getCy("clinicalanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_analytics");

  });
});
