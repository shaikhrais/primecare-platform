// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hsw_incident_reports", () => {
  it("opens and verifies screen hsw_incident_reports", () => {
    cy.loginAsRole("hsw");

  cy.task("log", "⏳ PROGRESS: - Navigating to /clinical/hsw-incident-reports (HswIncidentReportsScreen)...");
  cy.visitWithSemantics("/clinical/hsw-incident-reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HswIncidentReportsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hswincidentreports-screen").should("be.visible");
  cy.getCy("hswincidentreports-title").should("be.visible");
  cy.getCy("hswincidentreports-content").should("be.visible");
  cy.getCy("incident-report-btn").should("be.visible");
  cy.getCy("health-status-update-btn").should("be.visible");
  cy.getCy("care-plan-access-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HswIncidentReportsScreen...");
  cy.waitAndSee();
  cy.screenshot("hsw_incident_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified HswIncidentReportsScreen successfully!\n");

  });
});
