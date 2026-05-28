// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - architecture_planning_analytics", () => {
  it("opens and verifies screen architecture_planning_analytics", () => {
    cy.loginAsRole("infrastructure");

  cy.visitWithSemantics("/common/architecture-planning-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("architectureplanninganalytics-screen").should("be.visible");
  cy.getCy("architectureplanninganalytics-title").should("be.visible");
  cy.getCy("architectureplanninganalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("architecture_planning_analytics");

  });
});
