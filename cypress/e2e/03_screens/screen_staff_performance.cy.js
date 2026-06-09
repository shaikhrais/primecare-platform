// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - staff_performance", () => {
  it("opens and verifies screen staff_performance", () => {
    cy.loginAsRole("clinical_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/clinical_director/staff-performance (StaffPerformanceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/staff-performance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for StaffPerformanceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffperformance-screen").should("be.visible");
  cy.getCy("staffperformance-title").should("be.visible");
  cy.getCy("staffperformance-content").should("be.visible");
  cy.getCy("staffperformance-kpi-widget").should("be.visible");
  cy.getCy("staffperformance-compliance-card").should("be.visible");
  cy.getCy("staffperformance-satisfaction-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for StaffPerformanceScreen...");
  cy.waitAndSee();
  cy.screenshot("staff_performance");
  
  cy.task("log", "✅ PROGRESS: - Verified StaffPerformanceScreen successfully!\n");

  });
});
