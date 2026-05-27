// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_workflow", () => {
  it("opens and verifies screen franchise_workflow", () => {
    cy.loginAsRole("owner");

  cy.visit("/common/franchise-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseworkflow-screen").should("be.visible");
  cy.getCy("franchiseworkflow-title").should("be.visible");
  cy.getCy("franchiseworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_workflow");

  });
});
