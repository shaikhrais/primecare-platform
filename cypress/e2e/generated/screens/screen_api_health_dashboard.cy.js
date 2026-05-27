// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - api_health_dashboard", () => {
  it("opens and verifies screen api_health_dashboard", () => {
    cy.loginAsRole("governance");

  cy.visit("/common/api-health-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("apihealthdashboard-screen").should("be.visible");
  cy.getCy("apihealthdashboard-title").should("be.visible");
  cy.getCy("apihealthdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("api_health_dashboard");

  });
});
