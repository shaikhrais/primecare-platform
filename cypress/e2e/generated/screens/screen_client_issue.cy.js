// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - client_issue", () => {
  it("opens and verifies screen client_issue", () => {
    cy.loginAsRole("customer_support");

  cy.visit("/staff/client-issue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clientissue-screen").should("be.visible");
  cy.getCy("clientissue-title").should("be.visible");
  cy.getCy("clientissue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("client_issue");

  });
});
