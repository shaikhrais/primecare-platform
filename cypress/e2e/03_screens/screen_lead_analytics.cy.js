// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - lead_analytics", () => {
  it("opens and verifies screen lead_analytics", () => {
    cy.loginAsRole("marketing");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/lead-analytics (LeadAnalyticsScreen)...");
  cy.visitWithSemantics("/management/lead-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for LeadAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("leadanalytics-screen").should("be.visible");
  cy.getCy("leadanalytics-title").should("be.visible");
  cy.getCy("leadanalytics-content").should("be.visible");
  cy.getCy("leadanalytics-btn-refresh").should("be.visible");
  cy.getCy("leadanalytics-btn-export").should("be.visible");
  cy.getCy("leadanalytics-btn-viewdetails").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for LeadAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("lead_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified LeadAnalyticsScreen successfully!\n");

  });
});
