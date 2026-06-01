// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - medical_library_access_portal", () => {
  it("opens and verifies screen medical_library_access_portal", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Medical Library Access Portal)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Medical Library Access Portal...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Medical Library Access Portal...");
  cy.waitAndSee();
  cy.screenshot("medical_library_access_portal");
  
  cy.task("log", "✅ PROGRESS: - Verified Medical Library Access Portal successfully!\n");

  });
});
