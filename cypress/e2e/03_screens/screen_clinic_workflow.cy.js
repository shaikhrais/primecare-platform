// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinic_workflow", () => {
  it("opens and verifies screen clinic_workflow", () => {
    cy.loginAsRole("clinical_director");

  cy.visitWithSemantics("/common/clinic-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicworkflow-screen").should("be.visible");
  cy.getCy("clinicworkflow-title").should("be.visible");
  cy.getCy("clinicworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinic_workflow");

  });
});
