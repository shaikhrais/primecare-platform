// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduling_health", () => {
  it("opens and verifies screen scheduling_health", () => {
    cy.loginAsRole("ops_manager");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/scheduling-health (SchedulingHealthScreen)...");
  cy.visitWithSemantics("/management/scheduling-health");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SchedulingHealthScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulinghealth-screen").should("be.visible");
  cy.getCy("schedulinghealth-title").should("be.visible");
  cy.getCy("schedulinghealth-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SchedulingHealthScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduling_health");
  
  cy.task("log", "✅ PROGRESS: - Verified SchedulingHealthScreen successfully!\n");

  });
});
