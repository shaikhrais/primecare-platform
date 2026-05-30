// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_visit_notes", () => {
  it("opens and verifies screen psw_visit_notes", () => {
    cy.loginAsRole("psw");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/psw/visit-notes (PswVisitNotesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/visit-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PswVisitNotesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswvisitnotes-screen").should("be.visible");
  cy.getCy("pswvisitnotes-title").should("be.visible");
  cy.getCy("pswvisitnotes-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PswVisitNotesScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_visit_notes");
  
  cy.task("log", "✅ PROGRESS: - Verified PswVisitNotesScreen successfully!\n");

  });
});
