// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - onboarding_checklist", () => {
  it("opens and verifies screen onboarding_checklist", () => {
    cy.loginAsRole("hr_hiring");

  cy.visit("/staff/onboarding-checklist");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("onboardingchecklist-screen").should("be.visible");
  cy.getCy("onboardingchecklist-title").should("be.visible");
  cy.getCy("onboardingchecklist-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("onboarding_checklist");

  });
});
