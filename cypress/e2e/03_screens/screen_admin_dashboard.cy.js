// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - admin_dashboard", () => {
  it("opens and verifies screen admin_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/admin/dashboard (Admin Dashboard)...");
  cy.visitWithSemantics("/offices/franchise/roles/admin/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Admin Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("admindashboard-screen").should("be.visible");
  cy.getCy("admindashboard-title").should("be.visible");
  cy.getCy("admindashboard-content").should("be.visible");
  cy.getCy("admin-dashboard-btn-manage-users").should("be.visible");
  cy.getCy("admin-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("admin-dashboard-btn-respond-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Admin Dashboard...");
  cy.waitAndSee();
  cy.screenshot("admin_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Admin Dashboard successfully!\n");

  });
});
