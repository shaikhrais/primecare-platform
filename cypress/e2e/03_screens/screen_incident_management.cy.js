// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - incident_management", () => {
  it("opens and verifies screen incident_management", () => {
    cy.loginAsRole("compliance");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/incident-management (IncidentManagementScreen)...");
  cy.visitWithSemantics("/management/incident-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for IncidentManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incidentmanagement-screen").should("be.visible");
  cy.getCy("incidentmanagement-title").should("be.visible");
  cy.getCy("incidentmanagement-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for IncidentManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("incident_management");
  
  cy.task("log", "✅ PROGRESS: - Verified IncidentManagementScreen successfully!\n");

  });
});
