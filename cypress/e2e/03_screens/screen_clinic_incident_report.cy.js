// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinic_incident_report", () => {
  it("opens and verifies screen clinic_incident_report", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Clinic Incident Report)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Clinic Incident Report...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicincidentreport-screen").should("be.visible");
  cy.getCy("clinicincidentreport-title").should("be.visible");
  cy.getCy("clinicincidentreport-content").should("be.visible");
  cy.getCy("clinic-incident-report-table").should("be.visible");
  cy.getCy("loading-indicator").should("be.visible");
  cy.getCy("error-notification").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Clinic Incident Report...");
  cy.waitAndSee();
  cy.screenshot("clinic_incident_report");
  
  cy.task("log", "✅ PROGRESS: - Verified Clinic Incident Report successfully!\n");

  });
});
