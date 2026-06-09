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

  cy.getCy("operationalefficiencymetrics-screen").should("be.visible");
  cy.getCy("operationalefficiencymetrics-title").should("be.visible");
  cy.getCy("operationalefficiencymetrics-content").should("be.visible");
  cy.getCy("operational-efficiency-refresh").should("be.visible");
  cy.getCy("operational-efficiency-compare").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Operational Efficiency Metrics...");
  cy.waitAndSee();
  cy.screenshot("operational_efficiency_metrics");
  
  cy.task("log", "✅ PROGRESS: - Verified Operational Efficiency Metrics successfully!\n");

  });
});
