// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chronic_care_management_tracker", () => {
  it("opens and verifies screen chronic_care_management_tracker", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Chronic Care Management Tracker)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Chronic Care Management Tracker...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Chronic Care Management Tracker...");
  cy.waitAndSee();
  cy.screenshot("chronic_care_management_tracker");
  
  cy.task("log", "✅ PROGRESS: - Verified Chronic Care Management Tracker successfully!\n");

  });
});
