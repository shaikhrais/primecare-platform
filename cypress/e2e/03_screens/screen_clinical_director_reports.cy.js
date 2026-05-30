// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinical_director_reports", () => {
  it("opens and verifies screen clinical_director_reports", () => {
    cy.loginAsRole("clinical_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/clinical_director/reports (ClinicalDirectorReportsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ClinicalDirectorReportsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorreports-screen").should("be.visible");
  cy.getCy("clinicaldirectorreports-title").should("be.visible");
  cy.getCy("clinicaldirectorreports-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ClinicalDirectorReportsScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_director_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified ClinicalDirectorReportsScreen successfully!\n");

  });
});
