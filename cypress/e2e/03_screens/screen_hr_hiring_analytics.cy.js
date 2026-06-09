// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_hiring_analytics", () => {
  it("opens and verifies screen hr_hiring_analytics", () => {
    cy.loginAsRole("hr_hiring");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/hr-hiring-analytics (HrHiringAnalyticsScreen)...");
  cy.visitWithSemantics("/staff/hr-hiring-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HrHiringAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringanalytics-screen").should("be.visible");
  cy.getCy("hrhiringanalytics-title").should("be.visible");
  cy.getCy("hrhiringanalytics-content").should("be.visible");
  cy.getCy("hr_hiring_analytics-btn-refresh").should("be.visible");
  cy.getCy("hr_hiring_analytics-btn-export").should("be.visible");
  cy.getCy("hr_hiring_analytics-btn-add_position").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HrHiringAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified HrHiringAnalyticsScreen successfully!\n");

  });
});
