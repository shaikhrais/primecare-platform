// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - therapist_dashboard", () => {
  it("opens and verifies screen therapist_dashboard", () => {
    cy.loginAsRole("therapist");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/therapist/dashboard (TherapistDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/therapist/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for TherapistDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("therapistdashboard-screen").should("be.visible");
  cy.getCy("therapistdashboard-title").should("be.visible");
  cy.getCy("therapistdashboard-content").should("be.visible");
  cy.getCy("therapist-dashboard-btn-start-session").should("be.visible");
  cy.getCy("therapist-dashboard-btn-finalize-notes").should("be.visible");
  cy.getCy("therapist-dashboard-btn-run-compliance").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for TherapistDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("therapist_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified TherapistDashboardScreen successfully!\n");

  });
});
