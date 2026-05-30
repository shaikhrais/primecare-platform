// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physician_workflow", () => {
  it("opens and verifies screen physician_workflow", () => {
    cy.loginAsRole("physician");

  cy.task("log", "⏳ PROGRESS: - Navigating to /clinical/physician-workflow (Physician Compliance Workflow)...");
  cy.visitWithSemantics("/clinical/physician-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Physician Compliance Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physician compliance workflow-screen").should("be.visible");
  cy.getCy("physician compliance workflow-title").should("be.visible");
  cy.getCy("physician compliance workflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Physician Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("physician_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified Physician Compliance Workflow successfully!\n");

  });
});
