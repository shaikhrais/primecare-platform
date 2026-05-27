// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_messages", () => {
  it("opens and verifies screen patient_messages", () => {
    cy.loginAsRole("patient");

  cy.visit("/common/patient-messages");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientmessages-screen").should("be.visible");
  cy.getCy("patientmessages-title").should("be.visible");
  cy.getCy("patientmessages-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_messages");

  });
});
