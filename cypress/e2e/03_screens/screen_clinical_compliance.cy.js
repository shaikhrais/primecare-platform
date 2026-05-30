// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinical_compliance", () => {
  it("opens and verifies screen clinical_compliance", () => {
    cy.loginAsRole("clinical_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/clinical_director/compliance (ClinicalComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ClinicalComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalcompliance-screen").should("be.visible");
  cy.getCy("clinicalcompliance-title").should("be.visible");
  cy.getCy("clinicalcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ClinicalComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified ClinicalComplianceScreen successfully!\n");

  });
});
