// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - onboarding", () => {
  it("opens and verifies screen onboarding", () => {
    cy.loginAsRole("hr_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/onboarding (OnboardingScreen)...");
  cy.visitWithSemantics("/management/onboarding");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for OnboardingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("onboarding-screen").should("be.visible");
  cy.getCy("onboarding-title").should("be.visible");
  cy.getCy("onboarding-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for OnboardingScreen...");
  cy.waitAndSee();
  cy.screenshot("onboarding");
  
  cy.task("log", "✅ PROGRESS: - Verified OnboardingScreen successfully!\n");

  });
});
