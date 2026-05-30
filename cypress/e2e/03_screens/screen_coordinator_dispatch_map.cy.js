// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coordinator_dispatch_map", () => {
  it("opens and verifies screen coordinator_dispatch_map", () => {
    cy.loginAsRole("scheduler");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/coordinator-dispatch-map (CoordinatorDispatchMapScreen)...");
  cy.visitWithSemantics("/staff/coordinator-dispatch-map");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CoordinatorDispatchMapScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coordinatordispatchmap-screen").should("be.visible");
  cy.getCy("coordinatordispatchmap-title").should("be.visible");
  cy.getCy("coordinatordispatchmap-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CoordinatorDispatchMapScreen...");
  cy.waitAndSee();
  cy.screenshot("coordinator_dispatch_map");
  
  cy.task("log", "✅ PROGRESS: - Verified CoordinatorDispatchMapScreen successfully!\n");

  });
});
