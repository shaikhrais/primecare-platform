// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinical_compliance", () => {
  it("opens and verifies screen clinical_compliance", () => {
    cy.loginAsRole("clinical_director");

  cy.visit("/clinical/clinical-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalcompliance-screen").should("be.visible");
  cy.getCy("clinicalcompliance-title").should("be.visible");
  cy.getCy("clinicalcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_compliance");

  });
});
