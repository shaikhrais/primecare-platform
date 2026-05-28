// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinical_director_staff_quality", () => {
  it("opens and verifies screen clinical_director_staff_quality", () => {
    cy.loginAsRole("clinical_director");

  cy.visitWithSemantics("/clinical/clinical-director-staff-quality");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorstaffquality-screen").should("be.visible");
  cy.getCy("clinicaldirectorstaffquality-title").should("be.visible");
  cy.getCy("clinicaldirectorstaffquality-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_director_staff_quality");

  });
});
