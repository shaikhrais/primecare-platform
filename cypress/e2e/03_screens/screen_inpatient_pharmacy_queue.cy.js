// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - inpatient_pharmacy_queue", () => {
  it("opens and verifies screen inpatient_pharmacy_queue", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Inpatient Pharmacy Queue)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Inpatient Pharmacy Queue...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Inpatient Pharmacy Queue...");
  cy.waitAndSee();
  cy.screenshot("inpatient_pharmacy_queue");
  
  cy.task("log", "✅ PROGRESS: - Verified Inpatient Pharmacy Queue successfully!\n");

  });
});
