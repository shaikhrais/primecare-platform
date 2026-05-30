// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - architecture_planning_analytics", () => {
  it("opens and verifies screen architecture_planning_analytics", () => {
    cy.loginAsRole("infrastructure");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/architecture-planning-analytics (ArchitecturePlanningAnalyticsScreen)...");
  cy.visitWithSemantics("/common/architecture-planning-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ArchitecturePlanningAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("architectureplanninganalytics-screen").should("be.visible");
  cy.getCy("architectureplanninganalytics-title").should("be.visible");
  cy.getCy("architectureplanninganalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ArchitecturePlanningAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("architecture_planning_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified ArchitecturePlanningAnalyticsScreen successfully!\n");

  });
});
