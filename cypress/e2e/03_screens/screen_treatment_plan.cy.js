// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - treatment_plan", () => {
  it("opens and verifies screen treatment_plan", () => {
    cy.loginAsRole("physio");

  cy.visitWithSemantics("/clinical/treatment-plan");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("treatmentplan-screen").should("be.visible");
  cy.getCy("treatmentplan-title").should("be.visible");
  cy.getCy("treatmentplan-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("treatment_plan");

  });
});
