// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - general_manager_analytics", () => {
  it("opens and verifies screen general_manager_analytics", () => {
    cy.loginAsRole("gm");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/general-manager-analytics (GeneralManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/general-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for GeneralManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("generalmanageranalytics-screen").should("be.visible");
  cy.getCy("generalmanageranalytics-title").should("be.visible");
  cy.getCy("generalmanageranalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for GeneralManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("general_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified GeneralManagerAnalyticsScreen successfully!\n");

  });
});
