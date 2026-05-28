// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_hiring_workflow", () => {
  it("opens and verifies screen hr_hiring_workflow", () => {
    cy.loginAsRole("hr_hiring");

  cy.visitWithSemantics("/staff/hr-hiring-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringworkflow-screen").should("be.visible");
  cy.getCy("hrhiringworkflow-title").should("be.visible");
  cy.getCy("hrhiringworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_workflow");

  });
});
