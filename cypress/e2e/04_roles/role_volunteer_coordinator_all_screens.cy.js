// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - volunteer_coordinator", () => {
  it("tests all screens for role volunteer_coordinator", () => {
    cy.loginAsRole("volunteer_coordinator");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Navigating to /offices/corporate/roles/volunteer_coordinator/dashboard (VolunteerCoordinatorDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/volunteer_coordinator/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Checking shell & content for VolunteerCoordinatorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatordashboard-screen").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-title").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Saving screenshot for VolunteerCoordinatorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Verified VolunteerCoordinatorDashboardScreen successfully!\n");

  });
});
