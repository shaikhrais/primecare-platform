// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - interview_scheduling", () => {
  it("opens and verifies screen interview_scheduling", () => {
    cy.loginAsRole("hr_hiring");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/interview-scheduling (InterviewSchedulingScreen)...");
  cy.visitWithSemantics("/staff/interview-scheduling");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for InterviewSchedulingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("interviewscheduling-screen").should("be.visible");
  cy.getCy("interviewscheduling-title").should("be.visible");
  cy.getCy("interviewscheduling-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for InterviewSchedulingScreen...");
  cy.waitAndSee();
  cy.screenshot("interview_scheduling");
  
  cy.task("log", "✅ PROGRESS: - Verified InterviewSchedulingScreen successfully!\n");

  });
});
