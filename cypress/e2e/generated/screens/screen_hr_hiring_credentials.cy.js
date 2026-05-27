// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_hiring_credentials", () => {
  it("opens and verifies screen hr_hiring_credentials", () => {
    cy.loginAsRole("hr_hiring");

  cy.visit("/staff/hr-hiring-credentials");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringcredentials-screen").should("be.visible");
  cy.getCy("hrhiringcredentials-title").should("be.visible");
  cy.getCy("hrhiringcredentials-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_credentials");

  });
});
