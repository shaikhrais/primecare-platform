// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - adverse_event_reporting_portal", () => {
  it("opens and verifies screen adverse_event_reporting_portal", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Adverse Event Reporting Portal)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Adverse Event Reporting Portal...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Adverse Event Reporting Portal...");
  cy.waitAndSee();
  cy.screenshot("adverse_event_reporting_portal");
  
  cy.task("log", "✅ PROGRESS: - Verified Adverse Event Reporting Portal successfully!\n");

  });
});
