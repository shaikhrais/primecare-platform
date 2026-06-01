// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_visit_checklist", () => {
  it("opens and verifies screen psw_visit_checklist", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Psw Visit Checklist)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Psw Visit Checklist...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Psw Visit Checklist...");
  cy.waitAndSee();
  cy.screenshot("psw_visit_checklist");
  
  cy.task("log", "✅ PROGRESS: - Verified Psw Visit Checklist successfully!\n");

  });
});
