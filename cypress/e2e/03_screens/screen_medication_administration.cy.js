// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - medication_administration", () => {
  it("opens and verifies screen medication_administration", () => {
    cy.loginAsRole("rn");

  cy.visitWithSemantics("/rn/medication-administration");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("medicationadministration-screen").should("be.visible");
  cy.getCy("medicationadministration-title").should("be.visible");
  cy.getCy("medicationadministration-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("medication_administration");

  });
});
