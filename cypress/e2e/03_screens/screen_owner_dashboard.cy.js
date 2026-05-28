// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - owner_dashboard", () => {
  it("opens and verifies screen owner_dashboard", () => {
    cy.loginAsRole("owner");

  cy.visitWithSemantics("/executive/owner-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ownerdashboard-screen").should("be.visible");
  cy.getCy("ownerdashboard-title").should("be.visible");
  cy.getCy("ownerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("owner_dashboard");

  });
});
