// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_scheduling_health", () => {
  it("opens and verifies screen coo_scheduling_health", () => {
    cy.loginAsRole("coo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/coo-scheduling-health (CooSchedulingHealthScreen)...");
  cy.visitWithSemantics("/executive/coo-scheduling-health");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CooSchedulingHealthScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cooschedulinghealth-screen").should("be.visible");
  cy.getCy("cooschedulinghealth-title").should("be.visible");
  cy.getCy("cooschedulinghealth-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CooSchedulingHealthScreen...");
  cy.waitAndSee();
  cy.screenshot("coo_scheduling_health");
  
  cy.task("log", "✅ PROGRESS: - Verified CooSchedulingHealthScreen successfully!\n");

  });
});
