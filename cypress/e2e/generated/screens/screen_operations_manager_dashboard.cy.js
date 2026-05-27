// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - operations_manager_dashboard", () => {
  it("opens and verifies screen operations_manager_dashboard", () => {
    cy.loginAsRole("ops_manager");

  cy.visit("/management/operations-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanagerdashboard-screen").should("be.visible");
  cy.getCy("operationsmanagerdashboard-title").should("be.visible");
  cy.getCy("operationsmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("operations_manager_dashboard");

  });
});
