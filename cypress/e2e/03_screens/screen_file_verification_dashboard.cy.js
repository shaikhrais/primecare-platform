// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - file_verification_dashboard", () => {
  it("opens and verifies screen file_verification_dashboard", () => {
    cy.loginAsRole("governance");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/file-verification-dashboard (FileVerificationDashboardScreen)...");
  cy.visitWithSemantics("/common/file-verification-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FileVerificationDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("fileverificationdashboard-screen").should("be.visible");
  cy.getCy("fileverificationdashboard-title").should("be.visible");
  cy.getCy("fileverificationdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FileVerificationDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("file_verification_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified FileVerificationDashboardScreen successfully!\n");

  });
});
