// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_documents", () => {
  it("opens and verifies screen patient_documents", () => {
    cy.loginAsRole("patient");

  cy.visit("/common/patient-documents");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientdocuments-screen").should("be.visible");
  cy.getCy("patientdocuments-title").should("be.visible");
  cy.getCy("patientdocuments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_documents");

  });
});
