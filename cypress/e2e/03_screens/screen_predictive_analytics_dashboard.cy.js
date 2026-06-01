// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - predictive_analytics_dashboard", () => {
  it("opens and verifies screen predictive_analytics_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Predictive Analytics Dashboard)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Predictive Analytics Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Predictive Analytics Dashboard...");
  cy.waitAndSee();
  cy.screenshot("predictive_analytics_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Predictive Analytics Dashboard successfully!\n");

  });
});
