// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - client_progress", () => {
  it("opens and verifies screen client_progress", () => {
    cy.loginAsRole("rmt");

  cy.visit("/allied/client-progress");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clientprogress-screen").should("be.visible");
  cy.getCy("clientprogress-title").should("be.visible");
  cy.getCy("clientprogress-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("client_progress");

  });
});
