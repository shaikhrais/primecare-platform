// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physician_dashboard", () => {
  it("opens and verifies screen physician_dashboard", () => {
    cy.loginAsRole("physician");

  cy.task("log", "⏳ PROGRESS: - Navigating to /clinical/physician-dashboard (PhysicianDashboardScreen)...");
  cy.visitWithSemantics("/clinical/physician-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PhysicianDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiciandashboard-screen").should("be.visible");
  cy.getCy("physiciandashboard-title").should("be.visible");
  cy.getCy("physiciandashboard-content").should("be.visible");
  cy.getCy("physician-dashboard-btn-submit-prescription").should("be.visible");
  cy.getCy("physician-dashboard-btn-authorize-lab-order").should("be.visible");
  cy.getCy("physician-dashboard-btn-run-compliance-scan").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PhysicianDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("physician_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified PhysicianDashboardScreen successfully!\n");

  });
});
