// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_dashboard", () => {
  it("opens and verifies screen psw_dashboard", () => {
    cy.loginAsRole("psw");

  cy.visitWithSemantics("/psw/psw-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswdashboard-screen").should("be.visible");
  cy.getCy("pswdashboard-title").should("be.visible");
  cy.getCy("pswdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_dashboard");

  });
});
