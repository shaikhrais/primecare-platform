// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - partnership_manager_workflow", () => {
  it("opens and verifies screen partnership_manager_workflow", () => {
    cy.loginAsRole("partnership");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/partnership-manager-workflow (PartnershipManagerWorkflowScreen)...");
  cy.visitWithSemantics("/management/partnership-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PartnershipManagerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagerworkflow-screen").should("be.visible");
  cy.getCy("partnershipmanagerworkflow-title").should("be.visible");
  cy.getCy("partnershipmanagerworkflow-content").should("be.visible");
  cy.getCy("partnerships-overview-card").should("be.visible");
  cy.getCy("performance-metrics-chart").should("be.visible");
  cy.getCy("alerts-notification").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PartnershipManagerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("partnership_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified PartnershipManagerWorkflowScreen successfully!\n");

  });
});
