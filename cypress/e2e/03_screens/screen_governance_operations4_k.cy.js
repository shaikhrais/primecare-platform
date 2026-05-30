// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - governance_operations4_k", () => {
  it("opens and verifies screen governance_operations4_k", () => {
    cy.loginAsRole("governance");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/governance-operations4-k (GovernanceOperations4KScreen)...");
  cy.visitWithSemantics("/common/governance-operations4-k");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for GovernanceOperations4KScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceoperations4k-screen").should("be.visible");
  cy.getCy("governanceoperations4k-title").should("be.visible");
  cy.getCy("governanceoperations4k-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for GovernanceOperations4KScreen...");
  cy.waitAndSee();
  cy.screenshot("governance_operations4_k");
  
  cy.task("log", "✅ PROGRESS: - Verified GovernanceOperations4KScreen successfully!\n");

  });
});
