// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinical_outcomes_report", () => {
  it("opens and verifies screen clinical_outcomes_report", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Clinical Outcomes Report)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Clinical Outcomes Report...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Clinical Outcomes Report...");
  cy.waitAndSee();
  cy.screenshot("clinical_outcomes_report");
  
  cy.task("log", "✅ PROGRESS: - Verified Clinical Outcomes Report successfully!\n");

  });
});
