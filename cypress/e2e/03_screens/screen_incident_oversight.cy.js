// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - incident_oversight", () => {
  it("opens and verifies screen incident_oversight", () => {
    cy.loginAsRole("clinical_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/clinical_director/incident-oversight (IncidentOversightScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/incident-oversight");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for IncidentOversightScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incidentoversight-screen").should("be.visible");
  cy.getCy("incidentoversight-title").should("be.visible");
  cy.getCy("incidentoversight-content").should("be.visible");
  cy.getCy("incident-report-widget").should("be.visible");
  cy.getCy("compliance-scan-results-widget").should("be.visible");
  cy.getCy("kpi-metrics-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for IncidentOversightScreen...");
  cy.waitAndSee();
  cy.screenshot("incident_oversight");
  
  cy.task("log", "✅ PROGRESS: - Verified IncidentOversightScreen successfully!\n");

  });
});
