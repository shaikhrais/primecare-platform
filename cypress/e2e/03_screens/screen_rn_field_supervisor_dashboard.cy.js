// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_field_supervisor_dashboard", () => {
  it("opens and verifies screen rn_field_supervisor_dashboard", () => {
    cy.loginAsRole("rn_field_supervisor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /rn/rn-field-supervisor-dashboard (RnFieldSupervisorDashboardScreen)...");
  cy.visitWithSemantics("/rn/rn-field-supervisor-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RnFieldSupervisorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnfieldsupervisordashboard-screen").should("be.visible");
  cy.getCy("rnfieldsupervisordashboard-title").should("be.visible");
  cy.getCy("rnfieldsupervisordashboard-content").should("be.visible");
  cy.getCy("rnfdashboard-btn-submit-audit").should("be.visible");
  cy.getCy("rnfdashboard-btn-update-policy").should("be.visible");
  cy.getCy("rnfdashboard-btn-export-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RnFieldSupervisorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified RnFieldSupervisorDashboardScreen successfully!\n");

  });
});
