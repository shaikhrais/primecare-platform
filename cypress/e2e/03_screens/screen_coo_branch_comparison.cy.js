// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_branch_comparison", () => {
  it("opens and verifies screen coo_branch_comparison", () => {
    cy.loginAsRole("coo");

  cy.visitWithSemantics("/executive/coo-branch-comparison");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coobranchcomparison-screen").should("be.visible");
  cy.getCy("coobranchcomparison-title").should("be.visible");
  cy.getCy("coobranchcomparison-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_branch_comparison");

  });
});
