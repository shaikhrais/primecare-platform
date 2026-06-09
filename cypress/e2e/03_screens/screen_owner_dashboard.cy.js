// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - owner_dashboard", () => {
  it("opens and verifies screen owner_dashboard", () => {
    cy.loginAsRole("owner");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/owner/dashboard (OwnerDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/owner/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for OwnerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ownerdashboard-screen").should("be.visible");
  cy.getCy("ownerdashboard-title").should("be.visible");
  cy.getCy("ownerdashboard-content").should("be.visible");
  cy.getCy("owner-dashboard-btn-refresh").should("be.visible");
  cy.getCy("owner-dashboard-btn-compliance-scan").should("be.visible");
  cy.getCy("owner-dashboard-btn-update-policies").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for OwnerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("owner_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified OwnerDashboardScreen successfully!\n");

  });
});
