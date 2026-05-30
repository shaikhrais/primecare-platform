// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - treatment_plan", () => {
  it("opens and verifies screen treatment_plan", () => {
    cy.loginAsRole("physio");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/physiotherapist/treatment-plan (TreatmentPlanScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/treatment-plan");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for TreatmentPlanScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("treatmentplan-screen").should("be.visible");
  cy.getCy("treatmentplan-title").should("be.visible");
  cy.getCy("treatmentplan-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for TreatmentPlanScreen...");
  cy.waitAndSee();
  cy.screenshot("treatment_plan");
  
  cy.task("log", "✅ PROGRESS: - Verified TreatmentPlanScreen successfully!\n");

  });
});
