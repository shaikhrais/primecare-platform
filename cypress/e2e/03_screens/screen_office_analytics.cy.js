// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - office_analytics", () => {
  it("opens and verifies screen office_analytics", () => {
    cy.loginAsRole("admin");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/office-analytics (OfficeAnalyticsScreen)...");
  cy.visitWithSemantics("/common/office-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for OfficeAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("officeanalytics-screen").should("be.visible");
  cy.getCy("officeanalytics-title").should("be.visible");
  cy.getCy("officeanalytics-content").should("be.visible");
  cy.getCy("officeanalytics-btn-addtask").should("be.visible");
  cy.getCy("officeanalytics-btn-schedule").should("be.visible");
  cy.getCy("officeanalytics-btn-logcommunication").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for OfficeAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("office_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified OfficeAnalyticsScreen successfully!\n");

  });
});
