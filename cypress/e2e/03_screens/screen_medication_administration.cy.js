// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - medication_administration", () => {
  it("opens and verifies screen medication_administration", () => {
    cy.loginAsRole("rn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rn/medication-administration (MedicationAdministrationScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/medication-administration");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for MedicationAdministrationScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("medicationadministration-screen").should("be.visible");
  cy.getCy("medicationadministration-title").should("be.visible");
  cy.getCy("medicationadministration-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for MedicationAdministrationScreen...");
  cy.waitAndSee();
  cy.screenshot("medication_administration");
  
  cy.task("log", "✅ PROGRESS: - Verified MedicationAdministrationScreen successfully!\n");

  });
});
