// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_medications", () => {
  it("opens and verifies screen rn_medications", () => {
    cy.loginAsRole("rn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rn/medications (RnMedicationsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/medications");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RnMedicationsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnmedications-screen").should("be.visible");
  cy.getCy("rnmedications-title").should("be.visible");
  cy.getCy("rnmedications-content").should("be.visible");
  cy.getCy("rn-dashboard-patient-status").should("be.visible");
  cy.getCy("rn-dashboard-medication-compliance").should("be.visible");
  cy.getCy("rn-dashboard-assessment-log").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RnMedicationsScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_medications");
  
  cy.task("log", "✅ PROGRESS: - Verified RnMedicationsScreen successfully!\n");

  });
});
