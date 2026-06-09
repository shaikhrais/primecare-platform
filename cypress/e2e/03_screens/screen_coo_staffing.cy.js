// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_staffing", () => {
  it("opens and verifies screen coo_staffing", () => {
    cy.loginAsRole("coo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/coo-staffing (CooStaffingScreen)...");
  cy.visitWithSemantics("/executive/coo-staffing");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CooStaffingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coostaffing-screen").should("be.visible");
  cy.getCy("coostaffing-title").should("be.visible");
  cy.getCy("coostaffing-content").should("be.visible");
  cy.getCy("coo-dashboard-refresh-metrics").should("be.visible");
  cy.getCy("coo-dashboard-view-report").should("be.visible");
  cy.getCy("coo-dashboard-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CooStaffingScreen...");
  cy.waitAndSee();
  cy.screenshot("coo_staffing");
  
  cy.task("log", "✅ PROGRESS: - Verified CooStaffingScreen successfully!\n");

  });
});
