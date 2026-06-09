// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - quality_assurance_dashboard", () => {
  it("opens and verifies screen quality_assurance_dashboard", () => {
    cy.loginAsRole("system_verification");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/quality-assurance-dashboard (QualityAssuranceDashboardScreen)...");
  cy.visitWithSemantics("/staff/quality-assurance-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for QualityAssuranceDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassurancedashboard-screen").should("be.visible");
  cy.getCy("qualityassurancedashboard-title").should("be.visible");
  cy.getCy("qualityassurancedashboard-content").should("be.visible");
  cy.getCy("qa-dashboard-btn-execute-scan").should("be.visible");
  cy.getCy("qa-dashboard-btn-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for QualityAssuranceDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("quality_assurance_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified QualityAssuranceDashboardScreen successfully!\n");

  });
});
