// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - premium_concierge_analytics", () => {
  it("opens and verifies screen premium_concierge_analytics", () => {
    cy.loginAsRole("premium_concierge");

  cy.task("log", "⏳ PROGRESS: - Navigating to /premium/premium-concierge-analytics (Premium Concierge Care Coordinator Analytics)...");
  cy.visitWithSemantics("/premium/premium-concierge-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Premium Concierge Care Coordinator Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("premium concierge care coordinator analytics-screen").should("be.visible");
  cy.getCy("premium concierge care coordinator analytics-title").should("be.visible");
  cy.getCy("premium concierge care coordinator analytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Premium Concierge Care Coordinator Analytics...");
  cy.waitAndSee();
  cy.screenshot("premium_concierge_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified Premium Concierge Care Coordinator Analytics successfully!\n");

  });
});
