// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - onboarding_checklist", () => {
  it("opens and verifies screen onboarding_checklist", () => {
    cy.loginAsRole("hr_hiring");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/onboarding-checklist (OnboardingChecklistScreen)...");
  cy.visitWithSemantics("/staff/onboarding-checklist");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for OnboardingChecklistScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("onboardingchecklist-screen").should("be.visible");
  cy.getCy("onboardingchecklist-title").should("be.visible");
  cy.getCy("onboardingchecklist-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for OnboardingChecklistScreen...");
  cy.waitAndSee();
  cy.screenshot("onboarding_checklist");
  
  cy.task("log", "✅ PROGRESS: - Verified OnboardingChecklistScreen successfully!\n");

  });
});
