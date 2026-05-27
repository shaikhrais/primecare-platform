// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_observation", () => {
  it("opens and verifies screen patient_observation", () => {
    cy.loginAsRole("rpn");

  cy.visit("/clinical/patient-observation");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientobservation-screen").should("be.visible");
  cy.getCy("patientobservation-title").should("be.visible");
  cy.getCy("patientobservation-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_observation");

  });
});
