// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_manager_ontario_dashboard", () => {
  it("opens and verifies screen regional_manager_ontario_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Regional Manager Ontario Dashboard)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Regional Manager Ontario Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Regional Manager Ontario Dashboard...");
  cy.waitAndSee();
  cy.screenshot("regional_manager_ontario_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Regional Manager Ontario Dashboard successfully!\n");

  });
});
