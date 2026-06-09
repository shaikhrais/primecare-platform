// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - campaign_performance_dashboard", () => {
  it("opens and verifies screen campaign_performance_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Campaign Performance Dashboard)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Campaign Performance Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("campaignperformancedashboard-screen").should("be.visible");
  cy.getCy("campaignperformancedashboard-title").should("be.visible");
  cy.getCy("campaignperformancedashboard-content").should("be.visible");
  cy.getCy("campaign-dashboard-refresh").should("be.visible");
  cy.getCy("campaign-dashboard-create").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Campaign Performance Dashboard...");
  cy.waitAndSee();
  cy.screenshot("campaign_performance_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Campaign Performance Dashboard successfully!\n");

  });
});
