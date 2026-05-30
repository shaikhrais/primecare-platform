// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - volunteer_coordinator_dashboard", () => {
  it("opens and verifies screen volunteer_coordinator_dashboard", () => {
    cy.loginAsRole("volunteer_coordinator");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/volunteer-coordinator-dashboard (VolunteerCoordinatorDashboardScreen)...");
  cy.visitWithSemantics("/staff/volunteer-coordinator-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for VolunteerCoordinatorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatordashboard-screen").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-title").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for VolunteerCoordinatorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified VolunteerCoordinatorDashboardScreen successfully!\n");

  });
});
