// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - employee_dashboard", () => {
  it("opens and verifies screen employee_dashboard", () => {
    cy.loginAsRole("employee");

  cy.visitWithSemantics("/staff/employee-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("employeedashboard-screen").should("be.visible");
  cy.getCy("employeedashboard-title").should("be.visible");
  cy.getCy("employeedashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("employee_dashboard");

  });
});
