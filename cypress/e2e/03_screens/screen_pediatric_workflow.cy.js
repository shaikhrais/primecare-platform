// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - pediatric_workflow", () => {
  it("opens and verifies screen pediatric_workflow", () => {
    cy.loginAsRole("pediatric");

  cy.visit("/clinical/pediatric-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pediatric specialist compliance workflow-screen").should("be.visible");
  cy.getCy("pediatric specialist compliance workflow-title").should("be.visible");
  cy.getCy("pediatric specialist compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("pediatric_workflow");

  });
});
