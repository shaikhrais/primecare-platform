// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - it_admin_dashboard", () => {
  it("opens and verifies screen it_admin_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/it_admin/dashboard (It Admin Dashboard)...");
  cy.visitWithSemantics("/offices/corporate/roles/it_admin/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for It Admin Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("itadmindashboard-screen").should("be.visible");
  cy.getCy("itadmindashboard-title").should("be.visible");
  cy.getCy("itadmindashboard-content").should("be.visible");
  cy.getCy("itadmin-dashboard-performance-metrics").should("be.visible");
  cy.getCy("itadmin-dashboard-user-management").should("be.visible");
  cy.getCy("itadmin-dashboard-alerts").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for It Admin Dashboard...");
  cy.waitAndSee();
  cy.screenshot("it_admin_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified It Admin Dashboard successfully!\n");

  });
});
