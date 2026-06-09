// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_manager_dashboard", () => {
  it("opens and verifies screen regional_manager_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/regional_manager/dashboard (Regional Manager Dashboard)...");
  cy.visitWithSemantics("/offices/franchise/roles/regional_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Regional Manager Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalmanagerdashboard-screen").should("be.visible");
  cy.getCy("regionalmanagerdashboard-title").should("be.visible");
  cy.getCy("regionalmanagerdashboard-content").should("be.visible");
  cy.getCy("dashboard-sales-performance").should("be.visible");
  cy.getCy("dashboard-sales-trend").should("be.visible");
  cy.getCy("dashboard-team-performance").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Regional Manager Dashboard...");
  cy.waitAndSee();
  cy.screenshot("regional_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Regional Manager Dashboard successfully!\n");

  });
});
