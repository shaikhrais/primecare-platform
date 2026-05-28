// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - architecture_planning_dashboard", () => {
  it("opens and verifies screen architecture_planning_dashboard", () => {
    cy.loginAsRole("cto");

  cy.visitWithSemantics("/common/architecture-planning-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("architectureplanningdashboard-screen").should("be.visible");
  cy.getCy("architectureplanningdashboard-title").should("be.visible");
  cy.getCy("architectureplanningdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("architecture_planning_dashboard");

  });
});
