// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - marketing_manager_dashboard", () => {
  it("opens and verifies screen marketing_manager_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/marketing_manager/dashboard (Marketing Manager Dashboard)...");
  cy.visitWithSemantics("/offices/franchise/roles/marketing_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Marketing Manager Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("marketingmanagerdashboard-screen").should("be.visible");
  cy.getCy("marketingmanagerdashboard-title").should("be.visible");
  cy.getCy("marketingmanagerdashboard-content").should("be.visible");
  cy.getCy("marketing-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("marketing-dashboard-btn-adjust-tactics").should("be.visible");
  cy.getCy("marketing-dashboard-btn-collaborate").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Marketing Manager Dashboard...");
  cy.waitAndSee();
  cy.screenshot("marketing_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Marketing Manager Dashboard successfully!\n");

  });
});
