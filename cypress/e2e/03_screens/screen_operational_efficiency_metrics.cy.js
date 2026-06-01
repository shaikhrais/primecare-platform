// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - operational_efficiency_metrics", () => {
  it("opens and verifies screen operational_efficiency_metrics", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Operational Efficiency Metrics)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Operational Efficiency Metrics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Operational Efficiency Metrics...");
  cy.waitAndSee();
  cy.screenshot("operational_efficiency_metrics");
  
  cy.task("log", "✅ PROGRESS: - Verified Operational Efficiency Metrics successfully!\n");

  });
});
