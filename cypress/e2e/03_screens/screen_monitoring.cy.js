// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - monitoring", () => {
  it("opens and verifies screen monitoring", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /governance/monitoring (Monitoring)...");
  cy.visitWithSemantics("/governance/monitoring");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Monitoring...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("monitoring-screen").should("be.visible");
  cy.getCy("monitoring-title").should("be.visible");
  cy.getCy("monitoring-content").should("be.visible");
  cy.getCy("dashboard-btn-refresh-metrics").should("be.visible");
  cy.getCy("dashboard-btn-view-logs").should("be.visible");
  cy.getCy("dashboard-btn-generate-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Monitoring...");
  cy.waitAndSee();
  cy.screenshot("monitoring");
  
  cy.task("log", "✅ PROGRESS: - Verified Monitoring successfully!\n");

  });
});
