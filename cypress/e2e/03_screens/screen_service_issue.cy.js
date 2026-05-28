// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - service_issue", () => {
  it("opens and verifies screen service_issue", () => {
    cy.loginAsRole("ops_manager");

  cy.visitWithSemantics("/management/service-issue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("serviceissue-screen").should("be.visible");
  cy.getCy("serviceissue-title").should("be.visible");
  cy.getCy("serviceissue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("service_issue");

  });
});
