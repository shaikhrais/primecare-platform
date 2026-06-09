// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractor_dashboard", () => {
  it("opens and verifies screen chiropractor_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/chiropractor/dashboard (ChiropractorDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ChiropractorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractordashboard-screen").should("be.visible");
  cy.getCy("chiropractordashboard-title").should("be.visible");
  cy.getCy("chiropractordashboard-content").should("be.visible");
  cy.getCy("chiropractor-btn-assessment").should("be.visible");
  cy.getCy("chiropractor-btn-treatment").should("be.visible");
  cy.getCy("chiropractor-btn-adjust").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ChiropractorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified ChiropractorDashboardScreen successfully!\n");

  });
});
