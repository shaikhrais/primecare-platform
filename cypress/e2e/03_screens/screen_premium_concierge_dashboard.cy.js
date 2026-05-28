// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - premium_concierge_dashboard", () => {
  it("opens and verifies screen premium_concierge_dashboard", () => {
    cy.loginAsRole("premium_concierge");

  cy.visitWithSemantics("/management/premium-concierge-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("premiumconciergedashboard-screen").should("be.visible");
  cy.getCy("premiumconciergedashboard-title").should("be.visible");
  cy.getCy("premiumconciergedashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("premium_concierge_dashboard");

  });
});
