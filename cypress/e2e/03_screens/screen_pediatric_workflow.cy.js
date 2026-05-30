// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - pediatric_workflow", () => {
  it("opens and verifies screen pediatric_workflow", () => {
    cy.loginAsRole("pediatric");

  cy.task("log", "⏳ PROGRESS: - Navigating to /clinical/pediatric-workflow (Pediatric Specialist Compliance Workflow)...");
  cy.visitWithSemantics("/clinical/pediatric-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Pediatric Specialist Compliance Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pediatric specialist compliance workflow-screen").should("be.visible");
  cy.getCy("pediatric specialist compliance workflow-title").should("be.visible");
  cy.getCy("pediatric specialist compliance workflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Pediatric Specialist Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("pediatric_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified Pediatric Specialist Compliance Workflow successfully!\n");

  });
});
