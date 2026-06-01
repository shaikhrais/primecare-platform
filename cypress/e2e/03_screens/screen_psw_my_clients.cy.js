// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_my_clients", () => {
  it("opens and verifies screen psw_my_clients", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Psw My Clients)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Psw My Clients...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Psw My Clients...");
  cy.waitAndSee();
  cy.screenshot("psw_my_clients");
  
  cy.task("log", "✅ PROGRESS: - Verified Psw My Clients successfully!\n");

  });
});
