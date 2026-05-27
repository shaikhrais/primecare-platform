// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - office_workflow", () => {
  it("opens and verifies screen office_workflow", () => {
    cy.loginAsRole("admin");

  cy.visit("/common/office-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("officeworkflow-screen").should("be.visible");
  cy.getCy("officeworkflow-title").should("be.visible");
  cy.getCy("officeworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("office_workflow");

  });
});
