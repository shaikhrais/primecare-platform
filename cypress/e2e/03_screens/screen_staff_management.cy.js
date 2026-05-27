// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - staff_management", () => {
  it("opens and verifies screen staff_management", () => {
    cy.loginAsRole("owner");

  cy.visit("/executive/staff-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffmanagement-screen").should("be.visible");
  cy.getCy("staffmanagement-title").should("be.visible");
  cy.getCy("staffmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("staff_management");

  });
});
