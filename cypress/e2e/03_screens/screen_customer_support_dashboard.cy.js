// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - customer_support_dashboard", () => {
  it("opens and verifies screen customer_support_dashboard", () => {
    cy.loginAsRole("dynamic");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/customer-support-dashboard (CustomerSupportDashboardScreen)...");
  cy.visitWithSemantics("/common/customer-support-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CustomerSupportDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("customersupportdashboard-screen").should("be.visible");
  cy.getCy("customersupportdashboard-title").should("be.visible");
  cy.getCy("customersupportdashboard-content").should("be.visible");
  cy.getCy("csdashboard-btn-compliance-scan").should("be.visible");
  cy.getCy("csdashboard-btn-manual-sync").should("be.visible");
  cy.getCy("csdashboard-btn-export-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CustomerSupportDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("customer_support_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified CustomerSupportDashboardScreen successfully!\n");

  });
});
