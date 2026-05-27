// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - tax_compliance", () => {
  it("opens and verifies screen tax_compliance", () => {
    cy.loginAsRole("cfo");

  cy.visit("/executive/tax-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("taxcompliance-screen").should("be.visible");
  cy.getCy("taxcompliance-title").should("be.visible");
  cy.getCy("taxcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("tax_compliance");

  });
});
