// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_coordinator_reports", () => {
  it("opens and verifies screen intake_coordinator_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Intake Coordinator Reports)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Intake Coordinator Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorreports-screen").should("be.visible");
  cy.getCy("intakecoordinatorreports-title").should("be.visible");
  cy.getCy("intakecoordinatorreports-content").should("be.visible");
  cy.getCy("intake-dashboard-metrics").should("be.visible");
  cy.getCy("intake-dashboard-alerts").should("be.visible");
  cy.getCy("intake-dashboard-reports").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Intake Coordinator Reports...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Intake Coordinator Reports successfully!\n");

  });
});
