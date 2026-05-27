// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - portal_compliance", () => {
  it("opens and verifies screen portal_compliance", () => {
    cy.loginAsRole("portal");

  cy.visit("/common/portal-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("portalcompliance-screen").should("be.visible");
  cy.getCy("portalcompliance-title").should("be.visible");
  cy.getCy("portalcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("portal_compliance");

  });
});
