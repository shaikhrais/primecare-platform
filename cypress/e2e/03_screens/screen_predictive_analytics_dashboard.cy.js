// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - predictive_analytics_dashboard", () => {
  it("opens and verifies screen predictive_analytics_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Predictive Analytics Dashboard)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Predictive Analytics Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("predictiveanalyticsdashboard-screen").should("be.visible");
  cy.getCy("predictiveanalyticsdashboard-title").should("be.visible");
  cy.getCy("predictiveanalyticsdashboard-content").should("be.visible");
  cy.getCy("analytics-btn-refresh").should("be.visible");
  cy.getCy("analytics-btn-run-model").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Predictive Analytics Dashboard...");
  cy.waitAndSee();
  cy.screenshot("predictive_analytics_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Predictive Analytics Dashboard successfully!\n");

  });
});
