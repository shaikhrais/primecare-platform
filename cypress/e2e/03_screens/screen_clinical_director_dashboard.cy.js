// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinical_director_dashboard", () => {
  it("opens and verifies screen clinical_director_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/clinical_director/dashboard (Clinical Director Dashboard)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Clinical Director Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectordashboard-screen").should("be.visible");
  cy.getCy("clinicaldirectordashboard-title").should("be.visible");
  cy.getCy("clinicaldirectordashboard-content").should("be.visible");
  cy.getCy("clinical-dashboard-metric-card").should("be.visible");
  cy.getCy("clinical-dashboard-alert-box").should("be.visible");
  cy.getCy("clinical-dashboard-trend-visualization").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Clinical Director Dashboard...");
  cy.waitAndSee();
  cy.screenshot("clinical_director_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Clinical Director Dashboard successfully!\n");

  });
});
