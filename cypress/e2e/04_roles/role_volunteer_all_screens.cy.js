// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - volunteer", () => {
  it("tests all screens for role volunteer", () => {
    cy.loginAsRole("volunteer");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [1/2 | 50%] - Navigating to /offices/corporate/roles/volunteer_coordinator/dashboard (VolunteerCoordinatorDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/volunteer_coordinator/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [1/2 | 50%] - Checking shell & content for VolunteerCoordinatorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatordashboard-screen").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-title").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [1/2 | 50%] - Saving screenshot for VolunteerCoordinatorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [1/2 | 50%] - Verified VolunteerCoordinatorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [2/2 | 100%] - Navigating to packages/primecare_ui/lib/src/screens/staff/volunteer_dashboard_screen.dart (VolunteerDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/staff/volunteer_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [2/2 | 100%] - Checking shell & content for VolunteerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteerdashboard-screen").should("be.visible");
  cy.getCy("volunteerdashboard-title").should("be.visible");
  cy.getCy("volunteerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [2/2 | 100%] - Saving screenshot for VolunteerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("volunteer_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [2/2 | 100%] - Verified VolunteerDashboardScreen successfully!\n");

  });
});
