// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - incident_report", () => {
  it("opens and verifies screen incident_report", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /clinic/incident-report (Incident Report)...");
  cy.visitWithSemantics("/clinic/incident-report");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Incident Report...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incidentreport-screen").should("be.visible");
  cy.getCy("incidentreport-title").should("be.visible");
  cy.getCy("incidentreport-content").should("be.visible");
  cy.getCy("incidentreport-btn-trigger-scan").should("be.visible");
  cy.getCy("incidentreport-btn-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Incident Report...");
  cy.waitAndSee();
  cy.screenshot("incident_report");
  
  cy.task("log", "✅ PROGRESS: - Verified Incident Report successfully!\n");

  });
});
