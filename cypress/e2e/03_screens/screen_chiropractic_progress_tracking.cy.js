// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractic_progress_tracking", () => {
  it("opens and verifies screen chiropractic_progress_tracking", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/chiropractor/chiropractic-progress-tracking (ChiropracticProgressTrackingScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/chiropractic-progress-tracking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ChiropracticProgressTrackingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropracticprogresstracking-screen").should("be.visible");
  cy.getCy("chiropracticprogresstracking-title").should("be.visible");
  cy.getCy("chiropracticprogresstracking-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ChiropracticProgressTrackingScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractic_progress_tracking");
  
  cy.task("log", "✅ PROGRESS: - Verified ChiropracticProgressTrackingScreen successfully!\n");

  });
});
