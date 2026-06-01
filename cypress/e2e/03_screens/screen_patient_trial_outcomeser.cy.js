// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_trial_outcomeser", () => {
  it("opens and verifies screen patient_trial_outcomeser", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Patient Trial Outcomeser)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Patient Trial Outcomeser...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Patient Trial Outcomeser...");
  cy.waitAndSee();
  cy.screenshot("patient_trial_outcomeser");
  
  cy.task("log", "✅ PROGRESS: - Verified Patient Trial Outcomeser successfully!\n");

  });
});
