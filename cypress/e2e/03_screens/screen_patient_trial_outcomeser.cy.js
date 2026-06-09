// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_trial_outcomeser", () => {
  it("opens and verifies screen patient_trial_outcomeser", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Patient Trial Outcomeser)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Patient Trial Outcomeser...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patienttrialoutcomeser-screen").should("be.visible");
  cy.getCy("patienttrialoutcomeser-title").should("be.visible");
  cy.getCy("patienttrialoutcomeser-content").should("be.visible");
  cy.getCy("patienttrial-outcomes-view").should("be.visible");
  cy.getCy("patienttrial-analyze-data").should("be.visible");
  cy.getCy("patienttrial-filter-outcomes").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Patient Trial Outcomeser...");
  cy.waitAndSee();
  cy.screenshot("patient_trial_outcomeser");
  
  cy.task("log", "✅ PROGRESS: - Verified Patient Trial Outcomeser successfully!\n");

  });
});
