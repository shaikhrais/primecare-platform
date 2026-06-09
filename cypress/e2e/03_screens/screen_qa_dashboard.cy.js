// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - qa_dashboard", () => {
  it("opens and verifies screen qa_dashboard", () => {
    cy.loginAsRole("system_verification");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/support/roles/quality_assurance/dashboard (QaDashboardScreen)...");
  cy.visitWithSemantics("/offices/support/roles/quality_assurance/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for QaDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qadashboard-screen").should("be.visible");
  cy.getCy("qadashboard-title").should("be.visible");
  cy.getCy("qadashboard-content").should("be.visible");
  cy.getCy("qa_dashboard-btn-execute-scan").should("be.visible");
  cy.getCy("qa_dashboard-btn-sync-posture").should("be.visible");
  cy.getCy("qa_dashboard-btn-export-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for QaDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("qa_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified QaDashboardScreen successfully!\n");

  });
});
