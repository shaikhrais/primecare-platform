// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - ciso_dashboard", () => {
  it("opens and verifies screen ciso_dashboard", () => {
    cy.loginAsRole("ciso");

  cy.visitWithSemantics("/executive/ciso-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cisodashboard-screen").should("be.visible");
  cy.getCy("cisodashboard-title").should("be.visible");
  cy.getCy("cisodashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("ciso_dashboard");

  });
});
