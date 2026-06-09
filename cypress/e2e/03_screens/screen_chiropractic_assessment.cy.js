// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractic_assessment", () => {
  it("opens and verifies screen chiropractic_assessment", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/chiropractor/chiropractic-assessment (ChiropracticAssessmentScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/chiropractic-assessment");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ChiropracticAssessmentScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropracticassessment-screen").should("be.visible");
  cy.getCy("chiropracticassessment-title").should("be.visible");
  cy.getCy("chiropracticassessment-content").should("be.visible");
  cy.getCy("chiropractic-assessment-save").should("be.visible");
  cy.getCy("chiropractic-treatment-update").should("be.visible");
  cy.getCy("chiropractic-adjustment-record").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ChiropracticAssessmentScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractic_assessment");
  
  cy.task("log", "✅ PROGRESS: - Verified ChiropracticAssessmentScreen successfully!\n");

  });
});
