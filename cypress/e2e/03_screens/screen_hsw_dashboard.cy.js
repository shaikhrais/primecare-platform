// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hsw_dashboard", () => {
  it("opens and verifies screen hsw_dashboard", () => {
    cy.loginAsRole("hsw");

  cy.visitWithSemantics("/clinical/hsw-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hswdashboard-screen").should("be.visible");
  cy.getCy("hswdashboard-title").should("be.visible");
  cy.getCy("hswdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hsw_dashboard");

  });
});
