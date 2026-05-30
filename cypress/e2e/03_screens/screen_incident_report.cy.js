// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - incident_report", () => {
  it("opens and verifies screen incident_report", () => {
    cy.loginAsRole("psw");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/psw/incident-report (IncidentReportScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/incident-report");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for IncidentReportScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incidentreport-screen").should("be.visible");
  cy.getCy("incidentreport-title").should("be.visible");
  cy.getCy("incidentreport-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for IncidentReportScreen...");
  cy.waitAndSee();
  cy.screenshot("incident_report");
  
  cy.task("log", "✅ PROGRESS: - Verified IncidentReportScreen successfully!\n");

  });
});
