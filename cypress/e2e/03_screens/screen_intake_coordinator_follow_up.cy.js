// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_coordinator_follow_up", () => {
  it("opens and verifies screen intake_coordinator_follow_up", () => {
    cy.loginAsRole("volunteer_coordinator");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/intake-coordinator-follow-up (IntakeCoordinatorFollowUpScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-follow-up");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for IntakeCoordinatorFollowUpScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorfollowup-screen").should("be.visible");
  cy.getCy("intakecoordinatorfollowup-title").should("be.visible");
  cy.getCy("intakecoordinatorfollowup-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for IntakeCoordinatorFollowUpScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_follow_up");
  
  cy.task("log", "✅ PROGRESS: - Verified IntakeCoordinatorFollowUpScreen successfully!\n");

  });
});
