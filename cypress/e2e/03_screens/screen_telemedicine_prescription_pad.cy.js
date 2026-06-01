// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - telemedicine_prescription_pad", () => {
  it("opens and verifies screen telemedicine_prescription_pad", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Telemedicine Prescription Pad)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Telemedicine Prescription Pad...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Telemedicine Prescription Pad...");
  cy.waitAndSee();
  cy.screenshot("telemedicine_prescription_pad");
  
  cy.task("log", "✅ PROGRESS: - Verified Telemedicine Prescription Pad successfully!\n");

  });
});
