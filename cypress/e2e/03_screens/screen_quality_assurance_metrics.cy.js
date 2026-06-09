// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - quality_assurance_metrics", () => {
  it("opens and verifies screen quality_assurance_metrics", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Quality Assurance Metrics)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Quality Assurance Metrics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassurancemetrics-screen").should("be.visible");
  cy.getCy("qualityassurancemetrics-title").should("be.visible");
  cy.getCy("qualityassurancemetrics-content").should("be.visible");
  cy.getCy("qa-metric-error-rate").should("be.visible");
  cy.getCy("qa-metric-test-coverage").should("be.visible");
  cy.getCy("qa-metric-mttr").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Quality Assurance Metrics...");
  cy.waitAndSee();
  cy.screenshot("quality_assurance_metrics");
  
  cy.task("log", "✅ PROGRESS: - Verified Quality Assurance Metrics successfully!\n");

  });
});
