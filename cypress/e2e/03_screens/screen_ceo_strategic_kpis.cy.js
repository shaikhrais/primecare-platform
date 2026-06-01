// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - ceo_strategic_kpis", () => {
  it("opens and verifies screen ceo_strategic_kpis", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Ceo Strategic Kpis)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Ceo Strategic Kpis...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Ceo Strategic Kpis...");
  cy.waitAndSee();
  cy.screenshot("ceo_strategic_kpis");
  
  cy.task("log", "✅ PROGRESS: - Verified Ceo Strategic Kpis successfully!\n");

  });
});
