// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - visit_notes", () => {
  it("opens and verifies screen visit_notes", () => {
    cy.loginAsRole("psw");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/psw/visit-notes (VisitNotesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/visit-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for VisitNotesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("visitnotes-screen").should("be.visible");
  cy.getCy("visitnotes-title").should("be.visible");
  cy.getCy("visitnotes-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for VisitNotesScreen...");
  cy.waitAndSee();
  cy.screenshot("visit_notes");
  
  cy.task("log", "✅ PROGRESS: - Verified VisitNotesScreen successfully!\n");

  });
});
