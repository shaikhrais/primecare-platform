// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coordinator_hub", () => {
  it("opens and verifies screen coordinator_hub", () => {
    cy.loginAsRole("scheduler");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/coordinator-hub (CoordinatorHubScreen)...");
  cy.visitWithSemantics("/staff/coordinator-hub");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CoordinatorHubScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coordinatorhub-screen").should("be.visible");
  cy.getCy("coordinatorhub-title").should("be.visible");
  cy.getCy("coordinatorhub-content").should("be.visible");
  cy.getCy("coordinatorhub-btn-assign-shift").should("be.visible");
  cy.getCy("coordinatorhub-btn-resolve-alert").should("be.visible");
  cy.getCy("coordinatorhub-btn-view-performance").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CoordinatorHubScreen...");
  cy.waitAndSee();
  cy.screenshot("coordinator_hub");
  
  cy.task("log", "✅ PROGRESS: - Verified CoordinatorHubScreen successfully!\n");

  });
});
