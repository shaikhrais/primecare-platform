// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - portal_dashboard", () => {
  it("opens and verifies screen portal_dashboard", () => {
    cy.loginAsRole("portal");

  cy.visitWithSemantics("/common/portal-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("portaldashboard-screen").should("be.visible");
  cy.getCy("portaldashboard-title").should("be.visible");
  cy.getCy("portaldashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("portal_dashboard");

  });
});
