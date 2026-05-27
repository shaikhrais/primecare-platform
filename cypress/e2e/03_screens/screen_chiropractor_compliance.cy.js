// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractor_compliance", () => {
  it("opens and verifies screen chiropractor_compliance", () => {
    cy.loginAsRole("chiropractor");

  cy.visit("/common/chiropractor-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorcompliance-screen").should("be.visible");
  cy.getCy("chiropractorcompliance-title").should("be.visible");
  cy.getCy("chiropractorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_compliance");

  });
});
