// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physiotherapist_assessment", () => {
  it("opens and verifies screen physiotherapist_assessment", () => {
    cy.loginAsRole("physio");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/physiotherapist/assessment (PhysiotherapistAssessmentScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/assessment");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PhysiotherapistAssessmentScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistassessment-screen").should("be.visible");
  cy.getCy("physiotherapistassessment-title").should("be.visible");
  cy.getCy("physiotherapistassessment-content").should("be.visible");
  cy.getCy("physio-assessment-save").should("be.visible");
  cy.getCy("physio-treatment-update").should("be.visible");
  cy.getCy("physio-progress-monitor").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PhysiotherapistAssessmentScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_assessment");
  
  cy.task("log", "✅ PROGRESS: - Verified PhysiotherapistAssessmentScreen successfully!\n");

  });
});
