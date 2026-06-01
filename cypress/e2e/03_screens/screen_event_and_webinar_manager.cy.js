// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - event_and_webinar_manager", () => {
  it("opens and verifies screen event_and_webinar_manager", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Event And Webinar Manager)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Event And Webinar Manager...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Event And Webinar Manager...");
  cy.waitAndSee();
  cy.screenshot("event_and_webinar_manager");
  
  cy.task("log", "✅ PROGRESS: - Verified Event And Webinar Manager successfully!\n");

  });
});
