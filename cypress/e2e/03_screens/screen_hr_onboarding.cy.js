// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_onboarding", () => {
  it("opens and verifies screen hr_onboarding", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Hr Onboarding)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Hr Onboarding...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hronboarding-screen").should("be.visible");
  cy.getCy("hronboarding-title").should("be.visible");
  cy.getCy("hronboarding-content").should("be.visible");
  cy.getCy("hr-onboarding-btn-promote").should("be.visible");
  cy.getCy("hr-onboarding-btn-view-details").should("be.visible");
  cy.getCy("hr-onboarding-filter-applicants").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Hr Onboarding...");
  cy.waitAndSee();
  cy.screenshot("hr_onboarding");
  
  cy.task("log", "✅ PROGRESS: - Verified Hr Onboarding successfully!\n");

  });
});
