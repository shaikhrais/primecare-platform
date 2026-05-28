// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - legal_dashboard", () => {
  it("opens and verifies screen legal_dashboard", () => {
    cy.loginAsRole("legal");

  cy.visitWithSemantics("/executive/legal-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("legaldashboard-screen").should("be.visible");
  cy.getCy("legaldashboard-title").should("be.visible");
  cy.getCy("legaldashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("legal_dashboard");

  });
});
