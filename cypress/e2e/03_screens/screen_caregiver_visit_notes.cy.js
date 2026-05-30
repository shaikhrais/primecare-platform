// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - caregiver_visit_notes", () => {
  it("opens and verifies screen caregiver_visit_notes", () => {
    cy.loginAsRole("caregiver");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/caregiver/visit-notes (CaregiverVisitNotesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/caregiver/visit-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CaregiverVisitNotesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregivervisitnotes-screen").should("be.visible");
  cy.getCy("caregivervisitnotes-title").should("be.visible");
  cy.getCy("caregivervisitnotes-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CaregiverVisitNotesScreen...");
  cy.waitAndSee();
  cy.screenshot("caregiver_visit_notes");
  
  cy.task("log", "✅ PROGRESS: - Verified CaregiverVisitNotesScreen successfully!\n");

  });
});
