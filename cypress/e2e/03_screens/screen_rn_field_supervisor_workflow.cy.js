// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_field_supervisor_workflow", () => {
  it("opens and verifies screen rn_field_supervisor_workflow", () => {
    cy.loginAsRole("rn_field_supervisor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /rn/rn-field-supervisor-workflow (Registered Nurse (RN) Field Supervisor Compliance Workflow)...");
  cy.visitWithSemantics("/rn/rn-field-supervisor-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Registered Nurse (RN) Field Supervisor Compliance Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnfieldsupervisorworkflow-screen").should("be.visible");
  cy.getCy("rnfieldsupervisorworkflow-title").should("be.visible");
  cy.getCy("rnfieldsupervisorworkflow-content").should("be.visible");
  cy.getCy("rnfieldsupervisor-btn-submit-compliance").should("be.visible");
  cy.getCy("rnfieldsupervisor-btn-request-training").should("be.visible");
  cy.getCy("rnfieldsupervisor-btn-log-field-visit").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Registered Nurse (RN) Field Supervisor Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified Registered Nurse (RN) Field Supervisor Compliance Workflow successfully!\n");

  });
});
