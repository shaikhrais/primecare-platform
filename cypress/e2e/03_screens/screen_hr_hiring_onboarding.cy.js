// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_hiring_onboarding", () => {
  it("opens and verifies screen hr_hiring_onboarding", () => {
    cy.loginAsRole("hr_hiring");

  cy.visit("/staff/hr-hiring-onboarding");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringonboarding-screen").should("be.visible");
  cy.getCy("hrhiringonboarding-title").should("be.visible");
  cy.getCy("hrhiringonboarding-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_onboarding");

  });
});
