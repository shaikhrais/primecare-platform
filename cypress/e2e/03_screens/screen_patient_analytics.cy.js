// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_analytics", () => {
  it("opens and verifies screen patient_analytics", () => {
    cy.loginAsRole("patient");

  cy.visitWithSemantics("/common/patient-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientanalytics-screen").should("be.visible");
  cy.getCy("patientanalytics-title").should("be.visible");
  cy.getCy("patientanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_analytics");

  });
});
