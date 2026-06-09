// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinical_quality", () => {
  it("opens and verifies screen clinical_quality", () => {
    cy.loginAsRole("clinical_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/clinical_director/quality (ClinicalQualityScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/quality");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ClinicalQualityScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalquality-screen").should("be.visible");
  cy.getCy("clinicalquality-title").should("be.visible");
  cy.getCy("clinicalquality-content").should("be.visible");
  cy.getCy("clinical-dashboard-btn-view-audit-logs").should("be.visible");
  cy.getCy("clinical-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("clinical-dashboard-btn-send-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ClinicalQualityScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_quality");
  
  cy.task("log", "✅ PROGRESS: - Verified ClinicalQualityScreen successfully!\n");

  });
});
