// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_profile", () => {
  it("opens and verifies screen patient_profile", () => {
    cy.loginAsRole("patient");

  cy.visit("/common/patient-profile");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientprofile-screen").should("be.visible");
  cy.getCy("patientprofile-title").should("be.visible");
  cy.getCy("patientprofile-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_profile");

  });
});
