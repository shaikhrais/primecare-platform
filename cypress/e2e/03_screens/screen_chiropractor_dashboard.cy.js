// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractor_dashboard", () => {
  it("opens and verifies screen chiropractor_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.visitWithSemantics("/common/chiropractor-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractordashboard-screen").should("be.visible");
  cy.getCy("chiropractordashboard-title").should("be.visible");
  cy.getCy("chiropractordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_dashboard");

  });
});
