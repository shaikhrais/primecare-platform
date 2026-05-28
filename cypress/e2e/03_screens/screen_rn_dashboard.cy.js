// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_dashboard", () => {
  it("opens and verifies screen rn_dashboard", () => {
    cy.loginAsRole("rn");

  cy.visitWithSemantics("/rn/rn-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rndashboard-screen").should("be.visible");
  cy.getCy("rndashboard-title").should("be.visible");
  cy.getCy("rndashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_dashboard");

  });
});
