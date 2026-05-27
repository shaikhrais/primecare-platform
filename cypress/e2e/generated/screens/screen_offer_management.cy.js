// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - offer_management", () => {
  it("opens and verifies screen offer_management", () => {
    cy.loginAsRole("hr_hiring");

  cy.visit("/staff/offer-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("offermanagement-screen").should("be.visible");
  cy.getCy("offermanagement-title").should("be.visible");
  cy.getCy("offermanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("offer_management");

  });
});
