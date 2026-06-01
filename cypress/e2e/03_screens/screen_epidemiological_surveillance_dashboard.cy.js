// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - epidemiological_surveillance_dashboard", () => {
  it("opens and verifies screen epidemiological_surveillance_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Epidemiological Surveillance Dashboard)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Epidemiological Surveillance Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Epidemiological Surveillance Dashboard...");
  cy.waitAndSee();
  cy.screenshot("epidemiological_surveillance_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Epidemiological Surveillance Dashboard successfully!\n");

  });
});
