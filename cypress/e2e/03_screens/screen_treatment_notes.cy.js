// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - treatment_notes", () => {
  it("opens and verifies screen treatment_notes", () => {
    cy.loginAsRole("rmt");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rmt/treatment-notes (TreatmentNotesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/treatment-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for TreatmentNotesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("treatmentnotes-screen").should("be.visible");
  cy.getCy("treatmentnotes-title").should("be.visible");
  cy.getCy("treatmentnotes-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for TreatmentNotesScreen...");
  cy.waitAndSee();
  cy.screenshot("treatment_notes");
  
  cy.task("log", "✅ PROGRESS: - Verified TreatmentNotesScreen successfully!\n");

  });
});
