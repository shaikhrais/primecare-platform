// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_dashboard", () => {
  it("opens and verifies screen patient_dashboard", () => {
    cy.loginAsRole("patient");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/client/roles/client/dashboard (PatientDashboardScreen)...");
  cy.visitWithSemantics("/offices/client/roles/client/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PatientDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientdashboard-screen").should("be.visible");
  cy.getCy("patientdashboard-title").should("be.visible");
  cy.getCy("patientdashboard-content").should("be.visible");
  cy.getCy("patientdashboard-btn-refresh").should("be.visible");
  cy.getCy("patientdashboard-btn-audit").should("be.visible");
  cy.getCy("patientdashboard-btn-compliance").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PatientDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified PatientDashboardScreen successfully!\n");

  });
});
