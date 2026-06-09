// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_branch_operations", () => {
  it("opens and verifies screen coo_branch_operations", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/coo/branch-operations (Coo Branch Operations)...");
  cy.visitWithSemantics("/offices/corporate/roles/coo/branch-operations");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Coo Branch Operations...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coobranchoperations-screen").should("be.visible");
  cy.getCy("coobranchoperations-title").should("be.visible");
  cy.getCy("coobranchoperations-content").should("be.visible");
  cy.getCy("branchoperations-btn-review").should("be.visible");
  cy.getCy("branchoperations-btn-address").should("be.visible");
  cy.getCy("branchoperations-btn-collaborate").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Coo Branch Operations...");
  cy.waitAndSee();
  cy.screenshot("coo_branch_operations");
  
  cy.task("log", "✅ PROGRESS: - Verified Coo Branch Operations successfully!\n");

  });
});
