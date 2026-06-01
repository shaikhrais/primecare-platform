// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - ceo_alerts_and_risks", () => {
  it("opens and verifies screen ceo_alerts_and_risks", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Ceo Alerts And Risks)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Ceo Alerts And Risks...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Ceo Alerts And Risks...");
  cy.waitAndSee();
  cy.screenshot("ceo_alerts_and_risks");
  
  cy.task("log", "✅ PROGRESS: - Verified Ceo Alerts And Risks successfully!\n");

  });
});
