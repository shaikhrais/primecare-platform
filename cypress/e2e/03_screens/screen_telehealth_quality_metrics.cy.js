// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - telehealth_quality_metrics", () => {
  it("opens and verifies screen telehealth_quality_metrics", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Telehealth Quality Metrics)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Telehealth Quality Metrics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("telehealthqualitymetrics-screen").should("be.visible");
  cy.getCy("telehealthqualitymetrics-title").should("be.visible");
  cy.getCy("telehealthqualitymetrics-content").should("be.visible");
  cy.getCy("qualitymetrics-btn-generate-report").should("be.visible");
  cy.getCy("qualitymetrics-btn-update-metrics").should("be.visible");
  cy.getCy("qualitymetrics-btn-analyze-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Telehealth Quality Metrics...");
  cy.waitAndSee();
  cy.screenshot("telehealth_quality_metrics");
  
  cy.task("log", "✅ PROGRESS: - Verified Telehealth Quality Metrics successfully!\n");

  });
});
