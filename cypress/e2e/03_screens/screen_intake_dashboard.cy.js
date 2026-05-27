// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_dashboard", () => {
  it("opens and verifies screen intake_dashboard", () => {
    cy.loginAsRole("intake");

  cy.visit("/common/intake-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakedashboard-screen").should("be.visible");
  cy.getCy("intakedashboard-title").should("be.visible");
  cy.getCy("intakedashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_dashboard");

  });
});
