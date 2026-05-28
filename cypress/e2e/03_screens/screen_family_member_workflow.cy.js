// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - family_member_workflow", () => {
  it("opens and verifies screen family_member_workflow", () => {
    cy.loginAsRole("family");

  cy.visitWithSemantics("/common/family-member-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymemberworkflow-screen").should("be.visible");
  cy.getCy("familymemberworkflow-title").should("be.visible");
  cy.getCy("familymemberworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("family_member_workflow");

  });
});
