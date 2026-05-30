// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coordinator_sos", () => {
  it("opens and verifies screen coordinator_sos", () => {
    cy.loginAsRole("scheduler");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/coordinator-sos (CoordinatorSosScreen)...");
  cy.visitWithSemantics("/staff/coordinator-sos");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CoordinatorSosScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coordinatorsos-screen").should("be.visible");
  cy.getCy("coordinatorsos-title").should("be.visible");
  cy.getCy("coordinatorsos-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CoordinatorSosScreen...");
  cy.waitAndSee();
  cy.screenshot("coordinator_sos");
  
  cy.task("log", "✅ PROGRESS: - Verified CoordinatorSosScreen successfully!\n");

  });
});
