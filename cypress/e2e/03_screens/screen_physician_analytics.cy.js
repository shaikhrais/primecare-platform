// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physician_analytics", () => {
  it("opens and verifies screen physician_analytics", () => {
    cy.loginAsRole("physician");

  cy.task("log", "⏳ PROGRESS: - Navigating to /clinical/physician-analytics (Physician Analytics)...");
  cy.visitWithSemantics("/clinical/physician-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Physician Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiciananalytics-screen").should("be.visible");
  cy.getCy("physiciananalytics-title").should("be.visible");
  cy.getCy("physiciananalytics-content").should("be.visible");
  cy.getCy("physician-dashboard-healthmetrics").should("be.visible");
  cy.getCy("physician-dashboard-compliance").should("be.visible");
  cy.getCy("physician-dashboard-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Physician Analytics...");
  cy.waitAndSee();
  cy.screenshot("physician_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified Physician Analytics successfully!\n");

  });
});
