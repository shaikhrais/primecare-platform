// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - np_dashboard", () => {
  it("opens and verifies screen np_dashboard", () => {
    cy.loginAsRole("np");

  cy.visitWithSemantics("/clinical/np-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("npdashboard-screen").should("be.visible");
  cy.getCy("npdashboard-title").should("be.visible");
  cy.getCy("npdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("np_dashboard");

  });
});
