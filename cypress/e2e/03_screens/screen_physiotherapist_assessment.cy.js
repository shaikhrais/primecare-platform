// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physiotherapist_assessment", () => {
  it("opens and verifies screen physiotherapist_assessment", () => {
    cy.loginAsRole("physio");

  cy.visit("/allied/physiotherapist-assessment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistassessment-screen").should("be.visible");
  cy.getCy("physiotherapistassessment-title").should("be.visible");
  cy.getCy("physiotherapistassessment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_assessment");

  });
});
