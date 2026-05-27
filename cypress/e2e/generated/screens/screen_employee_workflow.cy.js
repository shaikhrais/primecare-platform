// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - employee_workflow", () => {
  it("opens and verifies screen employee_workflow", () => {
    cy.loginAsRole("employee");

  cy.visit("/staff/employee-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("employee compliance workflow-screen").should("be.visible");
  cy.getCy("employee compliance workflow-title").should("be.visible");
  cy.getCy("employee compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("employee_workflow");

  });
});
