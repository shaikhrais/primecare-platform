// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - staff_progress", () => {
  it("opens and verifies screen staff_progress", () => {
    cy.loginAsRole("training_coordinator");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/staff-progress (StaffProgressScreen)...");
  cy.visitWithSemantics("/staff/staff-progress");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for StaffProgressScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffprogress-screen").should("be.visible");
  cy.getCy("staffprogress-title").should("be.visible");
  cy.getCy("staffprogress-content").should("be.visible");
  cy.getCy("training-overview").should("be.visible");
  cy.getCy("engagement-metrics").should("be.visible");
  cy.getCy("feedback-results").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for StaffProgressScreen...");
  cy.waitAndSee();
  cy.screenshot("staff_progress");
  
  cy.task("log", "✅ PROGRESS: - Verified StaffProgressScreen successfully!\n");

  });
});
