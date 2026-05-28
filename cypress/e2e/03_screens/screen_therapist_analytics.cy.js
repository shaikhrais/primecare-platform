// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - therapist_analytics", () => {
  it("opens and verifies screen therapist_analytics", () => {
    cy.loginAsRole("therapist");

  cy.visitWithSemantics("/allied/therapist-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("therapist analytics-screen").should("be.visible");
  cy.getCy("therapist analytics-title").should("be.visible");
  cy.getCy("therapist analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("therapist_analytics");

  });
});
