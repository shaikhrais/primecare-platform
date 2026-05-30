// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - owner_analytics", () => {
  it("opens and verifies screen owner_analytics", () => {
    cy.loginAsRole("owner");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/owner-analytics (OwnerAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/owner-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for OwnerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("owneranalytics-screen").should("be.visible");
  cy.getCy("owneranalytics-title").should("be.visible");
  cy.getCy("owneranalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for OwnerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("owner_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified OwnerAnalyticsScreen successfully!\n");

  });
});
