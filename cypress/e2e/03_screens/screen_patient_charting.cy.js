// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_charting", () => {
  it("opens and verifies screen patient_charting", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Patient Charting)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Patient Charting...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientcharting-screen").should("be.visible");
  cy.getCy("patientcharting-title").should("be.visible");
  cy.getCy("patientcharting-content").should("be.visible");
  cy.getCy("patient-charting-loading-state").should("be.visible");
  cy.getCy("patient-charting-refresh-dashboard").should("be.visible");
  cy.getCy("patient-charting-trigger-scan").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Patient Charting...");
  cy.waitAndSee();
  cy.screenshot("patient_charting");
  
  cy.task("log", "✅ PROGRESS: - Verified Patient Charting successfully!\n");

  });
});
