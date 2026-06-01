// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - informed_consent_tracker", () => {
  it("opens and verifies screen informed_consent_tracker", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Informed Consent Tracker)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Informed Consent Tracker...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Informed Consent Tracker...");
  cy.waitAndSee();
  cy.screenshot("informed_consent_tracker");
  
  cy.task("log", "✅ PROGRESS: - Verified Informed Consent Tracker successfully!\n");

  });
});
