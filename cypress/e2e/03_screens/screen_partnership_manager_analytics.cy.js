// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - partnership_manager_analytics", () => {
  it("opens and verifies screen partnership_manager_analytics", () => {
    cy.loginAsRole("partnership");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/partnership-manager-analytics (PartnershipManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/partnership-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PartnershipManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanageranalytics-screen").should("be.visible");
  cy.getCy("partnershipmanageranalytics-title").should("be.visible");
  cy.getCy("partnershipmanageranalytics-content").should("be.visible");
  cy.getCy("partnerships-btn-generate-report").should("be.visible");
  cy.getCy("partnerships-btn-negotiate").should("be.visible");
  cy.getCy("partnerships-btn-address-issue").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PartnershipManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("partnership_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified PartnershipManagerAnalyticsScreen successfully!\n");

  });
});
