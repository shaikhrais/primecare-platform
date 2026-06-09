// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_manager_branch_comparison", () => {
  it("opens and verifies screen regional_manager_branch_comparison", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/regional_manager/branch_comparison (Regional Manager Branch Comparison)...");
  cy.visitWithSemantics("/offices/franchise/roles/regional_manager/branch_comparison");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Regional Manager Branch Comparison...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalmanagerbranchcomparison-screen").should("be.visible");
  cy.getCy("regionalmanagerbranchcomparison-title").should("be.visible");
  cy.getCy("regionalmanagerbranchcomparison-content").should("be.visible");
  cy.getCy("regional-manager-btn-generate-report").should("be.visible");
  cy.getCy("regional-manager-btn-collaborate").should("be.visible");
  cy.getCy("regional-manager-btn-review-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Regional Manager Branch Comparison...");
  cy.waitAndSee();
  cy.screenshot("regional_manager_branch_comparison");
  
  cy.task("log", "✅ PROGRESS: - Verified Regional Manager Branch Comparison successfully!\n");

  });
});
