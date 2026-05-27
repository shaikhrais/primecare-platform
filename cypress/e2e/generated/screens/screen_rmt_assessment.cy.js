// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rmt_assessment", () => {
  it("opens and verifies screen rmt_assessment", () => {
    cy.loginAsRole("rmt");

  cy.visit("/allied/rmt-assessment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtassessment-screen").should("be.visible");
  cy.getCy("rmtassessment-title").should("be.visible");
  cy.getCy("rmtassessment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_assessment");

  });
});
