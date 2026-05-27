// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - employee_analytics", () => {
  it("opens and verifies screen employee_analytics", () => {
    cy.loginAsRole("employee");

  cy.visit("/staff/employee-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("employee analytics-screen").should("be.visible");
  cy.getCy("employee analytics-title").should("be.visible");
  cy.getCy("employee analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("employee_analytics");

  });
});
