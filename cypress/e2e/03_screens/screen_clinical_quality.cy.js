// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinical_quality", () => {
  it("opens and verifies screen clinical_quality", () => {
    cy.loginAsRole("clinical_director");

  cy.visit("/clinical/clinical-quality");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalquality-screen").should("be.visible");
  cy.getCy("clinicalquality-title").should("be.visible");
  cy.getCy("clinicalquality-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_quality");

  });
});
