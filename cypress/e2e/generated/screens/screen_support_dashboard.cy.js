// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - support_dashboard", () => {
  it("opens and verifies screen support_dashboard", () => {
    cy.loginAsRole("dynamic");

  cy.visit("/common/support-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("supportdashboard-screen").should("be.visible");
  cy.getCy("supportdashboard-title").should("be.visible");
  cy.getCy("supportdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("support_dashboard");

  });
});
