// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - employee_records", () => {
  it("opens and verifies screen employee_records", () => {
    cy.loginAsRole("hr_director");

  cy.visit("/management/employee-records");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("employeerecords-screen").should("be.visible");
  cy.getCy("employeerecords-title").should("be.visible");
  cy.getCy("employeerecords-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("employee_records");

  });
});
