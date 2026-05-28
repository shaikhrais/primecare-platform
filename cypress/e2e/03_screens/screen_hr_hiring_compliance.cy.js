// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_hiring_compliance", () => {
  it("opens and verifies screen hr_hiring_compliance", () => {
    cy.loginAsRole("hr_hiring");

  cy.visitWithSemantics("/staff/hr-hiring-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringcompliance-screen").should("be.visible");
  cy.getCy("hrhiringcompliance-title").should("be.visible");
  cy.getCy("hrhiringcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_compliance");

  });
});
