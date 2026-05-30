// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physiotherapist_treatment_notes", () => {
  it("opens and verifies screen physiotherapist_treatment_notes", () => {
    cy.loginAsRole("physio");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/physiotherapist/treatment-notes (PhysiotherapistTreatmentNotesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/treatment-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PhysiotherapistTreatmentNotesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapisttreatmentnotes-screen").should("be.visible");
  cy.getCy("physiotherapisttreatmentnotes-title").should("be.visible");
  cy.getCy("physiotherapisttreatmentnotes-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PhysiotherapistTreatmentNotesScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_treatment_notes");
  
  cy.task("log", "✅ PROGRESS: - Verified PhysiotherapistTreatmentNotesScreen successfully!\n");

  });
});
