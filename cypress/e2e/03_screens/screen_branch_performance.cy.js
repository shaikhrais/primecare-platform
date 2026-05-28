// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - branch_performance", () => {
  it("opens and verifies screen branch_performance", () => {
    cy.loginAsRole("coo");

  cy.visitWithSemantics("/executive/branch-performance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("branchperformance-screen").should("be.visible");
  cy.getCy("branchperformance-title").should("be.visible");
  cy.getCy("branchperformance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("branch_performance");

  });
});
