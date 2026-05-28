// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - onboarding", () => {
  it("opens and verifies screen onboarding", () => {
    cy.loginAsRole("hr_director");

  cy.visitWithSemantics("/management/onboarding");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("onboarding-screen").should("be.visible");
  cy.getCy("onboarding-title").should("be.visible");
  cy.getCy("onboarding-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("onboarding");

  });
});
