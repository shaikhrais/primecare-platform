// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physiotherapist_treatment_notes", () => {
  it("opens and verifies screen physiotherapist_treatment_notes", () => {
    cy.loginAsRole("physio");

  cy.visitWithSemantics("/allied/physiotherapist-treatment-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapisttreatmentnotes-screen").should("be.visible");
  cy.getCy("physiotherapisttreatmentnotes-title").should("be.visible");
  cy.getCy("physiotherapisttreatmentnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_treatment_notes");

  });
});
