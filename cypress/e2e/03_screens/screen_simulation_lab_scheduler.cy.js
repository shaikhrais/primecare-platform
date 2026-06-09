// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - simulation_lab_scheduler", () => {
  it("opens and verifies screen simulation_lab_scheduler", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Simulation Lab Scheduler)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Simulation Lab Scheduler...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("simulationlabscheduler-screen").should("be.visible");
  cy.getCy("simulationlabscheduler-title").should("be.visible");
  cy.getCy("simulationlabscheduler-content").should("be.visible");
  cy.getCy("simulationlab-btn-refresh").should("be.visible");
  cy.getCy("simulationlab-btn-book").should("be.visible");
  cy.getCy("simulationlab-btn-details").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Simulation Lab Scheduler...");
  cy.waitAndSee();
  cy.screenshot("simulation_lab_scheduler");
  
  cy.task("log", "✅ PROGRESS: - Verified Simulation Lab Scheduler successfully!\n");

  });
});
