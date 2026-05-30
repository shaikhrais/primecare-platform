// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - family_member_analytics", () => {
  it("opens and verifies screen family_member_analytics", () => {
    cy.loginAsRole("family");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/family-member-analytics (FamilyMemberAnalyticsScreen)...");
  cy.visitWithSemantics("/common/family-member-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FamilyMemberAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymemberanalytics-screen").should("be.visible");
  cy.getCy("familymemberanalytics-title").should("be.visible");
  cy.getCy("familymemberanalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FamilyMemberAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("family_member_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified FamilyMemberAnalyticsScreen successfully!\n");

  });
});
