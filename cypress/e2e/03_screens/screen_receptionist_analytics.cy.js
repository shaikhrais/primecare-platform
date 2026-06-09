// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - receptionist_analytics", () => {
  it("opens and verifies screen receptionist_analytics", () => {
    cy.loginAsRole("admin");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/receptionist-analytics (ReceptionistAnalyticsScreen)...");
  cy.visitWithSemantics("/staff/receptionist-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ReceptionistAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistanalytics-screen").should("be.visible");
  cy.getCy("receptionistanalytics-title").should("be.visible");
  cy.getCy("receptionistanalytics-content").should("be.visible");
  cy.getCy("receptionist-analytics-btn-add-task").should("be.visible");
  cy.getCy("receptionist-analytics-btn-schedule-appointment").should("be.visible");
  cy.getCy("receptionist-analytics-btn-send-message").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ReceptionistAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("receptionist_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified ReceptionistAnalyticsScreen successfully!\n");

  });
});
