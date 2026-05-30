// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - adjustment_notes", () => {
  it("opens and verifies screen adjustment_notes", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/chiropractor/adjustment-notes (AdjustmentNotesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/adjustment-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for AdjustmentNotesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("adjustmentnotes-screen").should("be.visible");
  cy.getCy("adjustmentnotes-title").should("be.visible");
  cy.getCy("adjustmentnotes-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for AdjustmentNotesScreen...");
  cy.waitAndSee();
  cy.screenshot("adjustment_notes");
  
  cy.task("log", "✅ PROGRESS: - Verified AdjustmentNotesScreen successfully!\n");

  });
});
