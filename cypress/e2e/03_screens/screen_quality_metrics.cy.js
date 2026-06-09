// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - quality_metrics", () => {
  it("opens and verifies screen quality_metrics", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /generated/quality-metrics (Quality Metrics)...");
  cy.visitWithSemantics("/generated/quality-metrics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Quality Metrics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualitymetrics-screen").should("be.visible");
  cy.getCy("qualitymetrics-title").should("be.visible");
  cy.getCy("qualitymetrics-content").should("be.visible");
  cy.getCy("qualitymetrics-display").should("be.visible");
  cy.getCy("qualityalerts").should("be.visible");
  cy.getCy("historicaldata-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Quality Metrics...");
  cy.waitAndSee();
  cy.screenshot("quality_metrics");
  
  cy.task("log", "✅ PROGRESS: - Verified Quality Metrics successfully!\n");

  });
});
