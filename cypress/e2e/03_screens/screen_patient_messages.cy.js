// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_messages", () => {
  it("opens and verifies screen patient_messages", () => {
    cy.loginAsRole("patient");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/patient-messages (PatientMessagesScreen)...");
  cy.visitWithSemantics("/common/patient-messages");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PatientMessagesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientmessages-screen").should("be.visible");
  cy.getCy("patientmessages-title").should("be.visible");
  cy.getCy("patientmessages-content").should("be.visible");
  cy.getCy("patientmessages-btn-trigger-audit").should("be.visible");
  cy.getCy("patientmessages-btn-refresh-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PatientMessagesScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_messages");
  
  cy.task("log", "✅ PROGRESS: - Verified PatientMessagesScreen successfully!\n");

  });
});
