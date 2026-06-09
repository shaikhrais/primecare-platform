// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractor_treatment_notes", () => {
  it("opens and verifies screen chiropractor_treatment_notes", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/chiropractor/treatment-notes (ChiropractorTreatmentNotesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/treatment-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ChiropractorTreatmentNotesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractortreatmentnotes-screen").should("be.visible");
  cy.getCy("chiropractortreatmentnotes-title").should("be.visible");
  cy.getCy("chiropractortreatmentnotes-content").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-run-compliance-scan").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-view-feedback").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-generate-audit").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ChiropractorTreatmentNotesScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_treatment_notes");
  
  cy.task("log", "✅ PROGRESS: - Verified ChiropractorTreatmentNotesScreen successfully!\n");

  });
});
