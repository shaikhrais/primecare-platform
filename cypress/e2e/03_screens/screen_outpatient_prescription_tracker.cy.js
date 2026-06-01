// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - outpatient_prescription_tracker", () => {
  it("opens and verifies screen outpatient_prescription_tracker", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Outpatient Prescription Tracker)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Outpatient Prescription Tracker...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Outpatient Prescription Tracker...");
  cy.waitAndSee();
  cy.screenshot("outpatient_prescription_tracker");
  
  cy.task("log", "✅ PROGRESS: - Verified Outpatient Prescription Tracker successfully!\n");

  });
});
