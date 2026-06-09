// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - family_overview", () => {
  it("opens and verifies screen family_overview", () => {
    cy.loginAsRole("family");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/family-overview (FamilyOverviewScreen)...");
  cy.visitWithSemantics("/common/family-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FamilyOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familyoverview-screen").should("be.visible");
  cy.getCy("familyoverview-title").should("be.visible");
  cy.getCy("familyoverview-content").should("be.visible");
  cy.getCy("family-overview-btn-run-scan").should("be.visible");
  cy.getCy("family-overview-btn-trigger-action").should("be.visible");
  cy.getCy("family-overview-btn-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FamilyOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("family_overview");
  
  cy.task("log", "✅ PROGRESS: - Verified FamilyOverviewScreen successfully!\n");

  });
});
