// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinic_dashboard", () => {
  it("opens and verifies screen clinic_dashboard", () => {
    cy.loginAsRole("clinical_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/clinical_director/clinic-dashboard (ClinicDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/clinic-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ClinicDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicdashboard-screen").should("be.visible");
  cy.getCy("clinicdashboard-title").should("be.visible");
  cy.getCy("clinicdashboard-content").should("be.visible");
  cy.getCy("clinic-dashboard-btn-view-audit").should("be.visible");
  cy.getCy("clinic-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("clinic-dashboard-btn-send-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ClinicDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("clinic_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified ClinicDashboardScreen successfully!\n");

  });
});
