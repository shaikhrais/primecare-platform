// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - architecture_planning_compliance", () => {
  it("opens and verifies screen architecture_planning_compliance", () => {
    cy.loginAsRole("infrastructure");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/architecture-planning-compliance (ArchitecturePlanningComplianceScreen)...");
  cy.visitWithSemantics("/common/architecture-planning-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ArchitecturePlanningComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("architectureplanningcompliance-screen").should("be.visible");
  cy.getCy("architectureplanningcompliance-title").should("be.visible");
  cy.getCy("architectureplanningcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ArchitecturePlanningComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("architecture_planning_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified ArchitecturePlanningComplianceScreen successfully!\n");

  });
});
