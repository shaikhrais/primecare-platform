// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinical_director_quality_metrics", () => {
  it("opens and verifies screen clinical_director_quality_metrics", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Clinical Director Quality Metrics)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Clinical Director Quality Metrics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorqualitymetrics-screen").should("be.visible");
  cy.getCy("clinicaldirectorqualitymetrics-title").should("be.visible");
  cy.getCy("clinicaldirectorqualitymetrics-content").should("be.visible");
  cy.getCy("quality-metrics-card").should("be.visible");
  cy.getCy("trend-visualization-chart").should("be.visible");
  cy.getCy("alert-notification").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Clinical Director Quality Metrics...");
  cy.waitAndSee();
  cy.screenshot("clinical_director_quality_metrics");
  
  cy.task("log", "✅ PROGRESS: - Verified Clinical Director Quality Metrics successfully!\n");

  });
});
