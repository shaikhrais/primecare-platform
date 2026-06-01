// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_expansion_manager_open_territories", () => {
  it("opens and verifies screen territory_expansion_manager_open_territories", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Territory Expansion Manager Open Territories)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Territory Expansion Manager Open Territories...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Territory Expansion Manager Open Territories...");
  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_open_territories");
  
  cy.task("log", "✅ PROGRESS: - Verified Territory Expansion Manager Open Territories successfully!\n");

  });
});
