// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physiotherapist_analytics", () => {
  it("opens and verifies screen physiotherapist_analytics", () => {
    cy.loginAsRole("physio");

  cy.visitWithSemantics("/common/physiotherapist-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistanalytics-screen").should("be.visible");
  cy.getCy("physiotherapistanalytics-title").should("be.visible");
  cy.getCy("physiotherapistanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_analytics");

  });
});
