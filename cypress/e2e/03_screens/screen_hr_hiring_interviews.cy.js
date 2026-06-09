// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_hiring_interviews", () => {
  it("opens and verifies screen hr_hiring_interviews", () => {
    cy.loginAsRole("hr_hiring");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/hr_hiring/interviews (HrHiringInterviewsScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/hr_hiring/interviews");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HrHiringInterviewsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringinterviews-screen").should("be.visible");
  cy.getCy("hrhiringinterviews-title").should("be.visible");
  cy.getCy("hrhiringinterviews-content").should("be.visible");
  cy.getCy("recruitment-kpi-chart").should("be.visible");
  cy.getCy("recruitment-funnel-chart").should("be.visible");
  cy.getCy("diversity-metrics-widget").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HrHiringInterviewsScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_interviews");
  
  cy.task("log", "✅ PROGRESS: - Verified HrHiringInterviewsScreen successfully!\n");

  });
});
