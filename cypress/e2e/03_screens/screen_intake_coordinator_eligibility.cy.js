// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_coordinator_eligibility", () => {
  it("opens and verifies screen intake_coordinator_eligibility", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Intake Coordinator Eligibility)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Intake Coordinator Eligibility...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatoreligibility-screen").should("be.visible");
  cy.getCy("intakecoordinatoreligibility-title").should("be.visible");
  cy.getCy("intakecoordinatoreligibility-content").should("be.visible");
  cy.getCy("loading-indicator").should("be.visible");
  cy.getCy("error-log").should("be.visible");
  cy.getCy("user-feedback-section").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Intake Coordinator Eligibility...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_eligibility");
  
  cy.task("log", "✅ PROGRESS: - Verified Intake Coordinator Eligibility successfully!\n");

  });
});
