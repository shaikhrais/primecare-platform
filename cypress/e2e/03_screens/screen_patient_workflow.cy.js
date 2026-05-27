// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_workflow", () => {
  it("opens and verifies screen patient_workflow", () => {
    cy.loginAsRole("patient");

  cy.visit("/common/patient-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientworkflow-screen").should("be.visible");
  cy.getCy("patientworkflow-title").should("be.visible");
  cy.getCy("patientworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_workflow");

  });
});
