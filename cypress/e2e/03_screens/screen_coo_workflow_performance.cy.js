// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_workflow_performance", () => {
  it("opens and verifies screen coo_workflow_performance", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Coo Workflow Performance)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Coo Workflow Performance...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Coo Workflow Performance...");
  cy.waitAndSee();
  cy.screenshot("coo_workflow_performance");
  
  cy.task("log", "✅ PROGRESS: - Verified Coo Workflow Performance successfully!\n");

  });
});
