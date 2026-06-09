// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_coordinator_assessments", () => {
  it("opens and verifies screen intake_coordinator_assessments", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Intake Coordinator Assessments)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Intake Coordinator Assessments...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorassessments-screen").should("be.visible");
  cy.getCy("intakecoordinatorassessments-title").should("be.visible");
  cy.getCy("intakecoordinatorassessments-content").should("be.visible");
  cy.getCy("assessment-list").should("be.visible");
  cy.getCy("status-monitor").should("be.visible");
  cy.getCy("communication-tool").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Intake Coordinator Assessments...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_assessments");
  
  cy.task("log", "✅ PROGRESS: - Verified Intake Coordinator Assessments successfully!\n");

  });
});
