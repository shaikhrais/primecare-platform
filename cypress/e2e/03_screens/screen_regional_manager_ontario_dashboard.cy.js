// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_manager_ontario_dashboard", () => {
  it("opens and verifies screen regional_manager_ontario_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/regional_manager_ontario/dashboard (Regional Manager Ontario Dashboard)...");
  cy.visitWithSemantics("/offices/business_development/roles/regional_manager_ontario/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Regional Manager Ontario Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalmanagerontariodashboard-screen").should("be.visible");
  cy.getCy("regionalmanagerontariodashboard-title").should("be.visible");
  cy.getCy("regionalmanagerontariodashboard-content").should("be.visible");
  cy.getCy("ontario-dashboard-kpi").should("be.visible");
  cy.getCy("ontario-dashboard-report").should("be.visible");
  cy.getCy("ontario-dashboard-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Regional Manager Ontario Dashboard...");
  cy.waitAndSee();
  cy.screenshot("regional_manager_ontario_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Regional Manager Ontario Dashboard successfully!\n");

  });
});
