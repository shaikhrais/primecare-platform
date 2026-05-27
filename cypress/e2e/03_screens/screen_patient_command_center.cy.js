// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_command_center", () => {
  it("opens and verifies screen patient_command_center", () => {
    cy.loginAsRole("patient");

  cy.visit("/common/patient-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientcommandcenter-screen").should("be.visible");
  cy.getCy("patientcommandcenter-title").should("be.visible");
  cy.getCy("patientcommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_command_center");

  });
});
