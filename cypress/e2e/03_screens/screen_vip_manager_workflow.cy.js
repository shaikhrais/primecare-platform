// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - vip_manager_workflow", () => {
  it("opens and verifies screen vip_manager_workflow", () => {
    cy.loginAsRole("vip_manager");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/vip-manager-workflow (VIP Client Manager Compliance Workflow)...");
  cy.visitWithSemantics("/executive/vip-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for VIP Client Manager Compliance Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vip client manager compliance workflow-screen").should("be.visible");
  cy.getCy("vip client manager compliance workflow-title").should("be.visible");
  cy.getCy("vip client manager compliance workflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for VIP Client Manager Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("vip_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified VIP Client Manager Compliance Workflow successfully!\n");

  });
});
