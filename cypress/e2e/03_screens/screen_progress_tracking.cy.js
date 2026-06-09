// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - progress_tracking", () => {
  it("opens and verifies screen progress_tracking", () => {
    cy.loginAsRole("physio");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/physiotherapist/progress-tracking (ProgressTrackingScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/progress-tracking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ProgressTrackingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("progresstracking-screen").should("be.visible");
  cy.getCy("progresstracking-title").should("be.visible");
  cy.getCy("progresstracking-content").should("be.visible");
  cy.getCy("progress-tracking-btn-add-task").should("be.visible");
  cy.getCy("progress-tracking-btn-update-treatment").should("be.visible");
  cy.getCy("progress-tracking-btn-monitor").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ProgressTrackingScreen...");
  cy.waitAndSee();
  cy.screenshot("progress_tracking");
  
  cy.task("log", "✅ PROGRESS: - Verified ProgressTrackingScreen successfully!\n");

  });
});
