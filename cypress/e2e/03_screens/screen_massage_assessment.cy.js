// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - massage_assessment", () => {
  it("opens and verifies screen massage_assessment", () => {
    cy.loginAsRole("rmt");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rmt/massage-assessment (MassageAssessmentScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/massage-assessment");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for MassageAssessmentScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("massageassessment-screen").should("be.visible");
  cy.getCy("massageassessment-title").should("be.visible");
  cy.getCy("massageassessment-content").should("be.visible");
  cy.getCy("massage-assessment-btn-save").should("be.visible");
  cy.getCy("massage-assessment-btn-generate-plan").should("be.visible");
  cy.getCy("massage-assessment-btn-record-session").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for MassageAssessmentScreen...");
  cy.waitAndSee();
  cy.screenshot("massage_assessment");
  
  cy.task("log", "✅ PROGRESS: - Verified MassageAssessmentScreen successfully!\n");

  });
});
