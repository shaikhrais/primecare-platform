// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - remote_patient_monitoring_dashboard", () => {
  it("opens and verifies screen remote_patient_monitoring_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Remote Patient Monitoring Dashboard)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Remote Patient Monitoring Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Remote Patient Monitoring Dashboard...");
  cy.waitAndSee();
  cy.screenshot("remote_patient_monitoring_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Remote Patient Monitoring Dashboard successfully!\n");

  });
});
