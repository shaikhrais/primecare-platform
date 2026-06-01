// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regulatory_change_radar", () => {
  it("opens and verifies screen regulatory_change_radar", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Regulatory Change Radar)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Regulatory Change Radar...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Regulatory Change Radar...");
  cy.waitAndSee();
  cy.screenshot("regulatory_change_radar");
  
  cy.task("log", "✅ PROGRESS: - Verified Regulatory Change Radar successfully!\n");

  });
});
