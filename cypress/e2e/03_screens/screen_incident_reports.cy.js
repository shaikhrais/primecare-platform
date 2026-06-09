// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - incident_reports", () => {
  it("opens and verifies screen incident_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /generated/incident-reports (Incident Reports)...");
  cy.visitWithSemantics("/generated/incident-reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Incident Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incidentreports-screen").should("be.visible");
  cy.getCy("incidentreports-title").should("be.visible");
  cy.getCy("incidentreports-content").should("be.visible");
  cy.getCy("incident-reports-data-display").should("be.visible");
  cy.getCy("incident-reports-generate-report").should("be.visible");
  cy.getCy("incident-reports-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Incident Reports...");
  cy.waitAndSee();
  cy.screenshot("incident_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Incident Reports successfully!\n");

  });
});
