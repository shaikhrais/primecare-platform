// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rmt_assessment", () => {
  it("opens and verifies screen rmt_assessment", () => {
    cy.loginAsRole("rmt");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rmt/assessment (RmtAssessmentScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/assessment");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RmtAssessmentScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtassessment-screen").should("be.visible");
  cy.getCy("rmtassessment-title").should("be.visible");
  cy.getCy("rmtassessment-content").should("be.visible");
  cy.getCy("rmt-dashboard-client-overview").should("be.visible");
  cy.getCy("rmt-dashboard-compliance-status").should("be.visible");
  cy.getCy("rmt-dashboard-performance-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RmtAssessmentScreen...");
  cy.waitAndSee();
  cy.screenshot("rmt_assessment");
  
  cy.task("log", "✅ PROGRESS: - Verified RmtAssessmentScreen successfully!\n");

  });
});
