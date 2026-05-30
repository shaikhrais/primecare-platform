// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduling_operations4_k", () => {
  it("opens and verifies screen scheduling_operations4_k", () => {
    cy.loginAsRole("scheduler");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/scheduling-operations4-k (SchedulingOperations4KScreen)...");
  cy.visitWithSemantics("/staff/scheduling-operations4-k");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SchedulingOperations4KScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulingoperations4k-screen").should("be.visible");
  cy.getCy("schedulingoperations4k-title").should("be.visible");
  cy.getCy("schedulingoperations4k-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SchedulingOperations4KScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduling_operations4_k");
  
  cy.task("log", "✅ PROGRESS: - Verified SchedulingOperations4KScreen successfully!\n");

  });
});
