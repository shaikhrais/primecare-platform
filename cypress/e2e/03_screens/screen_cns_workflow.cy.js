// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cns_workflow", () => {
  it("opens and verifies screen cns_workflow", () => {
    cy.loginAsRole("cns");

  cy.task("log", "⏳ PROGRESS: - Navigating to /rn/cns-workflow (Clinical Nurse Specialist Compliance Workflow)...");
  cy.visitWithSemantics("/rn/cns-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Clinical Nurse Specialist Compliance Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cnsworkflow-screen").should("be.visible");
  cy.getCy("cnsworkflow-title").should("be.visible");
  cy.getCy("cnsworkflow-content").should("be.visible");
  cy.getCy("cns-dashboard-btn-update-care-plan").should("be.visible");
  cy.getCy("cns-dashboard-btn-report-red-flag").should("be.visible");
  cy.getCy("cns-dashboard-btn-training-resources").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Clinical Nurse Specialist Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("cns_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified Clinical Nurse Specialist Compliance Workflow successfully!\n");

  });
});
