// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_acquisition_cost_tracker", () => {
  it("opens and verifies screen patient_acquisition_cost_tracker", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Patient Acquisition Cost Tracker)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Patient Acquisition Cost Tracker...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Patient Acquisition Cost Tracker...");
  cy.waitAndSee();
  cy.screenshot("patient_acquisition_cost_tracker");
  
  cy.task("log", "✅ PROGRESS: - Verified Patient Acquisition Cost Tracker successfully!\n");

  });
});
