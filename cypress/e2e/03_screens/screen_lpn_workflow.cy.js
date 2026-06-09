// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - lpn_workflow", () => {
  it("opens and verifies screen lpn_workflow", () => {
    cy.loginAsRole("lpn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /rpn/lpn-workflow (Licensed Practical Nurse (LPN) Compliance Workflow)...");
  cy.visitWithSemantics("/rpn/lpn-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Licensed Practical Nurse (LPN) Compliance Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("lpnworkflow-screen").should("be.visible");
  cy.getCy("lpnworkflow-title").should("be.visible");
  cy.getCy("lpnworkflow-content").should("be.visible");
  cy.getCy("lpn-dashboard-btn-update-status").should("be.visible");
  cy.getCy("lpn-dashboard-btn-log-medication").should("be.visible");
  cy.getCy("lpn-dashboard-btn-report-incident").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Licensed Practical Nurse (LPN) Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("lpn_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified Licensed Practical Nurse (LPN) Compliance Workflow successfully!\n");

  });
});
