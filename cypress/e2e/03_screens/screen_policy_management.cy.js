// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - policy_management", () => {
  it("opens and verifies screen policy_management", () => {
    cy.loginAsRole("compliance");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/policy-management (PolicyManagementScreen)...");
  cy.visitWithSemantics("/management/policy-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PolicyManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("policymanagement-screen").should("be.visible");
  cy.getCy("policymanagement-title").should("be.visible");
  cy.getCy("policymanagement-content").should("be.visible");
  cy.getCy("compliance-audit-status").should("be.visible");
  cy.getCy("compliance-breach-count").should("be.visible");
  cy.getCy("regulatory-change-overview").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PolicyManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("policy_management");
  
  cy.task("log", "✅ PROGRESS: - Verified PolicyManagementScreen successfully!\n");

  });
});
