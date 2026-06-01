// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - it_administrator_dashboard", () => {
  it("opens and verifies screen it_administrator_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (It Administrator Dashboard)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for It Administrator Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for It Administrator Dashboard...");
  cy.waitAndSee();
  cy.screenshot("it_administrator_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified It Administrator Dashboard successfully!\n");

  });
});
