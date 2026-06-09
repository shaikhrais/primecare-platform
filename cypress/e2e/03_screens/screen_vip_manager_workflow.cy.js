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

  cy.getCy("vipmanagerworkflow-screen").should("be.visible");
  cy.getCy("vipmanagerworkflow-title").should("be.visible");
  cy.getCy("vipmanagerworkflow-content").should("be.visible");
  cy.getCy("vipmanager-btn-execute-scan").should("be.visible");
  cy.getCy("vipmanager-btn-resolve-issue").should("be.visible");
  cy.getCy("vipmanager-btn-update-dashboard").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for VIP Client Manager Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("vip_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified VIP Client Manager Compliance Workflow successfully!\n");

  });
});
