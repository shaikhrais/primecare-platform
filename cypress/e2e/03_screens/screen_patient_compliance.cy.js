// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_compliance", () => {
  it("opens and verifies screen patient_compliance", () => {
    cy.loginAsRole("patient");

  cy.visitWithSemantics("/common/patient-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientcompliance-screen").should("be.visible");
  cy.getCy("patientcompliance-title").should("be.visible");
  cy.getCy("patientcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_compliance");

  });
});
