// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinical_director_compliance", () => {
  it("opens and verifies screen clinical_director_compliance", () => {
    cy.loginAsRole("clinical_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/clinical_director/compliance-director (ClinicalDirectorComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/compliance-director");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ClinicalDirectorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorcompliance-screen").should("be.visible");
  cy.getCy("clinicaldirectorcompliance-title").should("be.visible");
  cy.getCy("clinicaldirectorcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ClinicalDirectorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_director_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified ClinicalDirectorComplianceScreen successfully!\n");

  });
});
