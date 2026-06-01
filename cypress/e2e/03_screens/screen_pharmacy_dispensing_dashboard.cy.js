// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - pharmacy_dispensing_dashboard", () => {
  it("opens and verifies screen pharmacy_dispensing_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Pharmacy Dispensing Dashboard)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Pharmacy Dispensing Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Pharmacy Dispensing Dashboard...");
  cy.waitAndSee();
  cy.screenshot("pharmacy_dispensing_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Pharmacy Dispensing Dashboard successfully!\n");

  });
});
