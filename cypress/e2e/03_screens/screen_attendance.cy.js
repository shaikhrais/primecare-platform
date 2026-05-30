// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - attendance", () => {
  it("opens and verifies screen attendance", () => {
    cy.loginAsRole("ops_manager");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/attendance (AttendanceScreen)...");
  cy.visitWithSemantics("/management/attendance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for AttendanceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("attendance-screen").should("be.visible");
  cy.getCy("attendance-title").should("be.visible");
  cy.getCy("attendance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for AttendanceScreen...");
  cy.waitAndSee();
  cy.screenshot("attendance");
  
  cy.task("log", "✅ PROGRESS: - Verified AttendanceScreen successfully!\n");

  });
});
