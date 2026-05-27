// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_director_onboarding", () => {
  it("opens and verifies screen hr_director_onboarding", () => {
    cy.loginAsRole("hr_director");

  cy.visit("/executive/hr-director-onboarding");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectoronboarding-screen").should("be.visible");
  cy.getCy("hrdirectoronboarding-title").should("be.visible");
  cy.getCy("hrdirectoronboarding-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_onboarding");

  });
});
