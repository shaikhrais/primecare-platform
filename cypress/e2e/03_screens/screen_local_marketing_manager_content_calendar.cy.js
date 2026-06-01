// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - local_marketing_manager_content_calendar", () => {
  it("opens and verifies screen local_marketing_manager_content_calendar", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Local Marketing Manager Content Calendar)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Local Marketing Manager Content Calendar...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Local Marketing Manager Content Calendar...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_content_calendar");
  
  cy.task("log", "✅ PROGRESS: - Verified Local Marketing Manager Content Calendar successfully!\n");

  });
});
