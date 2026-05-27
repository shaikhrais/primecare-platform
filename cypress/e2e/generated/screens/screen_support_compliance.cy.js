// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - support_compliance", () => {
  it("opens and verifies screen support_compliance", () => {
    cy.loginAsRole("customer_support");

  cy.visit("/common/support-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("supportcompliance-screen").should("be.visible");
  cy.getCy("supportcompliance-title").should("be.visible");
  cy.getCy("supportcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("support_compliance");

  });
});
