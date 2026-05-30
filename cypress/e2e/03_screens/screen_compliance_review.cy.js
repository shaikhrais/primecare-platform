// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - compliance_review", () => {
  it("opens and verifies screen compliance_review", () => {
    cy.loginAsRole("clinical_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/clinical_director/compliance-review (ComplianceReviewScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/compliance-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ComplianceReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancereview-screen").should("be.visible");
  cy.getCy("compliancereview-title").should("be.visible");
  cy.getCy("compliancereview-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ComplianceReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("compliance_review");
  
  cy.task("log", "✅ PROGRESS: - Verified ComplianceReviewScreen successfully!\n");

  });
});
