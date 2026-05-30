// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_coordinator_analytics", () => {
  it("opens and verifies screen intake_coordinator_analytics", () => {
    cy.loginAsRole("intake");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/intake_coordinator/coordinator-analytics (IntakeCoordinatorAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/coordinator-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for IntakeCoordinatorAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatoranalytics-screen").should("be.visible");
  cy.getCy("intakecoordinatoranalytics-title").should("be.visible");
  cy.getCy("intakecoordinatoranalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for IntakeCoordinatorAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified IntakeCoordinatorAnalyticsScreen successfully!\n");

  });
});
