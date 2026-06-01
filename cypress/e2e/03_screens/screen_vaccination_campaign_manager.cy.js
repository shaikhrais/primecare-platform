// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - vaccination_campaign_manager", () => {
  it("opens and verifies screen vaccination_campaign_manager", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Vaccination Campaign Manager)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Vaccination Campaign Manager...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Vaccination Campaign Manager...");
  cy.waitAndSee();
  cy.screenshot("vaccination_campaign_manager");
  
  cy.task("log", "✅ PROGRESS: - Verified Vaccination Campaign Manager successfully!\n");

  });
});
