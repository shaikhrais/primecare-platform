// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_coordinator_dashboard", () => {
  it("opens and verifies screen intake_coordinator_dashboard", () => {
    cy.loginAsRole("intake");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/intake_coordinator/dashboard (IntakeCoordinatorDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for IntakeCoordinatorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatordashboard-screen").should("be.visible");
  cy.getCy("intakecoordinatordashboard-title").should("be.visible");
  cy.getCy("intakecoordinatordashboard-content").should("be.visible");
  cy.getCy("intake-dashboard-active-operations").should("be.visible");
  cy.getCy("intake-dashboard-security-clearance").should("be.visible");
  cy.getCy("intake-dashboard-system-latency").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for IntakeCoordinatorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified IntakeCoordinatorDashboardScreen successfully!\n");

  });
});
