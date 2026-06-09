// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - np_workflow", () => {
  it("opens and verifies screen np_workflow", () => {
    cy.loginAsRole("np");

  cy.task("log", "⏳ PROGRESS: - Navigating to /rn/np-workflow (Nurse Practitioner (NP) Compliance Workflow)...");
  cy.visitWithSemantics("/rn/np-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Nurse Practitioner (NP) Compliance Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("npworkflow-screen").should("be.visible");
  cy.getCy("npworkflow-title").should("be.visible");
  cy.getCy("npworkflow-content").should("be.visible");
  cy.getCy("npworkflow-btn-submit-assessment").should("be.visible");
  cy.getCy("npworkflow-btn-update-care-plan").should("be.visible");
  cy.getCy("npworkflow-btn-prescribe-medication").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Nurse Practitioner (NP) Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("np_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified Nurse Practitioner (NP) Compliance Workflow successfully!\n");

  });
});
