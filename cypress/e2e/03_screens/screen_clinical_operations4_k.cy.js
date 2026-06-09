// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinical_operations4_k", () => {
  it("opens and verifies screen clinical_operations4_k", () => {
    cy.loginAsRole("clinical_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/clinical_director/operations4k (ClinicalOperations4KScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/operations4k");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ClinicalOperations4KScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaloperations4k-screen").should("be.visible");
  cy.getCy("clinicaloperations4k-title").should("be.visible");
  cy.getCy("clinicaloperations4k-content").should("be.visible");
  cy.getCy("clinical-dashboard-compliance-status").should("be.visible");
  cy.getCy("clinical-dashboard-performance-metrics").should("be.visible");
  cy.getCy("clinical-dashboard-staff-engagement").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ClinicalOperations4KScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_operations4_k");
  
  cy.task("log", "✅ PROGRESS: - Verified ClinicalOperations4KScreen successfully!\n");

  });
});
