// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - caregiver_incident_report", () => {
  it("opens and verifies screen caregiver_incident_report", () => {
    cy.loginAsRole("caregiver");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/caregiver/incident-report (CaregiverIncidentReportScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/caregiver/incident-report");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CaregiverIncidentReportScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregiverincidentreport-screen").should("be.visible");
  cy.getCy("caregiverincidentreport-title").should("be.visible");
  cy.getCy("caregiverincidentreport-content").should("be.visible");
  cy.getCy("dashboard-btn-report-incident").should("be.visible");
  cy.getCy("dashboard-btn-compliance-scan").should("be.visible");
  cy.getCy("dashboard-btn-view-audit").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CaregiverIncidentReportScreen...");
  cy.waitAndSee();
  cy.screenshot("caregiver_incident_report");
  
  cy.task("log", "✅ PROGRESS: - Verified CaregiverIncidentReportScreen successfully!\n");

  });
});
