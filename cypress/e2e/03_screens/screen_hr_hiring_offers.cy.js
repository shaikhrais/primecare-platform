// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_hiring_offers", () => {
  it("opens and verifies screen hr_hiring_offers", () => {
    cy.loginAsRole("hr_hiring");

  cy.visitWithSemantics("/staff/hr-hiring-offers");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringoffers-screen").should("be.visible");
  cy.getCy("hrhiringoffers-title").should("be.visible");
  cy.getCy("hrhiringoffers-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_offers");

  });
});
