// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - conflict_resolution", () => {
  it("opens and verifies screen conflict_resolution", () => {
    cy.loginAsRole("scheduler");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/conflict-resolution (ConflictResolutionScreen)...");
  cy.visitWithSemantics("/staff/conflict-resolution");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ConflictResolutionScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("conflictresolution-screen").should("be.visible");
  cy.getCy("conflictresolution-title").should("be.visible");
  cy.getCy("conflictresolution-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ConflictResolutionScreen...");
  cy.waitAndSee();
  cy.screenshot("conflict_resolution");
  
  cy.task("log", "✅ PROGRESS: - Verified ConflictResolutionScreen successfully!\n");

  });
});
