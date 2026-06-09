// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - ceo_dashboard", () => {
  it("opens and verifies screen ceo_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/ceo/dashboard (Ceo Dashboard)...");
  cy.visitWithSemantics("/offices/corporate/roles/ceo/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Ceo Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ceodashboard-screen").should("be.visible");
  cy.getCy("ceodashboard-title").should("be.visible");
  cy.getCy("ceodashboard-content").should("be.visible");
  cy.getCy("dashboard-kpi-visualization").should("be.visible");
  cy.getCy("dashboard-financial-summary").should("be.visible");
  cy.getCy("dashboard-project-overview").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Ceo Dashboard...");
  cy.waitAndSee();
  cy.screenshot("ceo_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Ceo Dashboard successfully!\n");

  });
});
