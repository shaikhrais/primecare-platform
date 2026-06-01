// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_coordinator_eligibility", () => {
  it("opens and verifies screen intake_coordinator_eligibility", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Intake Coordinator Eligibility)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Intake Coordinator Eligibility...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Intake Coordinator Eligibility...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_eligibility");
  
  cy.task("log", "✅ PROGRESS: - Verified Intake Coordinator Eligibility successfully!\n");

  });
});
