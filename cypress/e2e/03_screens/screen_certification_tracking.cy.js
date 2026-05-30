// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - certification_tracking", () => {
  it("opens and verifies screen certification_tracking", () => {
    cy.loginAsRole("training_coordinator");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/certification-tracking (CertificationTrackingScreen)...");
  cy.visitWithSemantics("/staff/certification-tracking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CertificationTrackingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("certificationtracking-screen").should("be.visible");
  cy.getCy("certificationtracking-title").should("be.visible");
  cy.getCy("certificationtracking-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CertificationTrackingScreen...");
  cy.waitAndSee();
  cy.screenshot("certification_tracking");
  
  cy.task("log", "✅ PROGRESS: - Verified CertificationTrackingScreen successfully!\n");

  });
});
