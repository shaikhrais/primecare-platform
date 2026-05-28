// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_dashboard", () => {
  it("opens and verifies screen patient_dashboard", () => {
    cy.loginAsRole("patient");

  cy.visitWithSemantics("/common/patient-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientdashboard-screen").should("be.visible");
  cy.getCy("patientdashboard-title").should("be.visible");
  cy.getCy("patientdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_dashboard");

  });
});
