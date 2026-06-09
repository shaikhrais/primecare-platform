// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_coordinator_intake_forms", () => {
  it("opens and verifies screen intake_coordinator_intake_forms", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Intake Coordinator Intake Forms)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Intake Coordinator Intake Forms...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorintakeforms-screen").should("be.visible");
  cy.getCy("intakecoordinatorintakeforms-title").should("be.visible");
  cy.getCy("intakecoordinatorintakeforms-content").should("be.visible");
  cy.getCy("intake-form-submit").should("be.visible");
  cy.getCy("intake-form-review").should("be.visible");
  cy.getCy("intake-follow-up").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Intake Coordinator Intake Forms...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_intake_forms");
  
  cy.task("log", "✅ PROGRESS: - Verified Intake Coordinator Intake Forms successfully!\n");

  });
});
