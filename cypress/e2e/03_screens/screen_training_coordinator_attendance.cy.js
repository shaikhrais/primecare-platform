// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_coordinator_attendance", () => {
  it("opens and verifies screen training_coordinator_attendance", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Training Coordinator Attendance)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Training Coordinator Attendance...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatorattendance-screen").should("be.visible");
  cy.getCy("trainingcoordinatorattendance-title").should("be.visible");
  cy.getCy("trainingcoordinatorattendance-content").should("be.visible");
  cy.getCy("attendance-monitor").should("be.visible");
  cy.getCy("attendance-update-btn").should("be.visible");
  cy.getCy("discrepancy-report-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Training Coordinator Attendance...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_attendance");
  
  cy.task("log", "✅ PROGRESS: - Verified Training Coordinator Attendance successfully!\n");

  });
});
