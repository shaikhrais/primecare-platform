// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - testing_overview", () => {
  it("opens and verifies screen testing_overview", () => {
    cy.loginAsRole("qa_specialist");

  cy.visitWithSemantics("/staff/testing-overview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("testingoverview-screen").should("be.visible");
  cy.getCy("testingoverview-title").should("be.visible");
  cy.getCy("testingoverview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("testing_overview");

  });
});
