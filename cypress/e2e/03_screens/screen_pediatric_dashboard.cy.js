// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - pediatric_dashboard", () => {
  it("opens and verifies screen pediatric_dashboard", () => {
    cy.loginAsRole("pediatric");

  cy.visitWithSemantics("/clinical/pediatric-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pediatricdashboard-screen").should("be.visible");
  cy.getCy("pediatricdashboard-title").should("be.visible");
  cy.getCy("pediatricdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("pediatric_dashboard");

  });
});
