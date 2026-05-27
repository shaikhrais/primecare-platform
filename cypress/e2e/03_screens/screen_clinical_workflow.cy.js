// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinical_workflow", () => {
  it("opens and verifies screen clinical_workflow", () => {
    cy.loginAsRole("clinical_director");

  cy.visit("/clinical/clinical-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalworkflow-screen").should("be.visible");
  cy.getCy("clinicalworkflow-title").should("be.visible");
  cy.getCy("clinicalworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_workflow");

  });
});
