// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - massage_assessment", () => {
  it("opens and verifies screen massage_assessment", () => {
    cy.loginAsRole("rmt");

  cy.visitWithSemantics("/allied/massage-assessment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("massageassessment-screen").should("be.visible");
  cy.getCy("massageassessment-title").should("be.visible");
  cy.getCy("massageassessment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("massage_assessment");

  });
});
