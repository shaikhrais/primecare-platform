// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physiotherapist_dashboard", () => {
  it("opens and verifies screen physiotherapist_dashboard", () => {
    cy.loginAsRole("physio");

  cy.visitWithSemantics("/common/physiotherapist-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistdashboard-screen").should("be.visible");
  cy.getCy("physiotherapistdashboard-title").should("be.visible");
  cy.getCy("physiotherapistdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_dashboard");

  });
});
