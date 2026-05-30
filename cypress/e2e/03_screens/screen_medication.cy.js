// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - medication", () => {
  it("opens and verifies screen medication", () => {
    cy.loginAsRole("rpn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rpn/medication (MedicationScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/medication");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for MedicationScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("medication-screen").should("be.visible");
  cy.getCy("medication-title").should("be.visible");
  cy.getCy("medication-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for MedicationScreen...");
  cy.waitAndSee();
  cy.screenshot("medication");
  
  cy.task("log", "✅ PROGRESS: - Verified MedicationScreen successfully!\n");

  });
});
