// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_hiring_onboarding", () => {
  it("opens and verifies screen hr_hiring_onboarding", () => {
    cy.loginAsRole("hr_hiring");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/hr_hiring/onboarding (HrHiringOnboardingScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/hr_hiring/onboarding");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HrHiringOnboardingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringonboarding-screen").should("be.visible");
  cy.getCy("hrhiringonboarding-title").should("be.visible");
  cy.getCy("hrhiringonboarding-content").should("be.visible");
  cy.getCy("ta-dashboard-btn-add-candidate").should("be.visible");
  cy.getCy("ta-dashboard-btn-schedule-interview").should("be.visible");
  cy.getCy("ta-dashboard-btn-generate-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HrHiringOnboardingScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_onboarding");
  
  cy.task("log", "✅ PROGRESS: - Verified HrHiringOnboardingScreen successfully!\n");

  });
});
