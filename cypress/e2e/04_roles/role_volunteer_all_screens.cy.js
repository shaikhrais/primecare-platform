// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - volunteer", () => {
  it("tests all screens for role volunteer", () => {
    cy.loginAsRole("volunteer");


  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/5 | 20%] - Navigating to /offices/corporate/roles/volunteer_coordinator/dashboard (VolunteerCoordinatorDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/volunteer_coordinator/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/5 | 20%] - Checking shell & content for VolunteerCoordinatorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatordashboard-screen").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-title").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/5 | 20%] - Saving screenshot for VolunteerCoordinatorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/5 | 20%] - Verified VolunteerCoordinatorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Navigating to /staff/volunteer-dashboard (VolunteerDashboardScreen)...");
  cy.visitWithSemantics("/staff/volunteer-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Checking shell & content for VolunteerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteerdashboard-screen").should("be.visible");
  cy.getCy("volunteerdashboard-title").should("be.visible");
  cy.getCy("volunteerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Saving screenshot for VolunteerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("volunteer_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Verified VolunteerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Navigating to /staff/volunteer-coordinator-analytics (VolunteerCoordinatorAnalyticsScreen)...");
  cy.visitWithSemantics("/staff/volunteer-coordinator-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Checking shell & content for VolunteerCoordinatorAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatoranalytics-screen").should("be.visible");
  cy.getCy("volunteercoordinatoranalytics-title").should("be.visible");
  cy.getCy("volunteercoordinatoranalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Saving screenshot for VolunteerCoordinatorAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Verified VolunteerCoordinatorAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Navigating to /staff/volunteer-coordinator-compliance (VolunteerCoordinatorComplianceScreen)...");
  cy.visitWithSemantics("/staff/volunteer-coordinator-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Checking shell & content for VolunteerCoordinatorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatorcompliance-screen").should("be.visible");
  cy.getCy("volunteercoordinatorcompliance-title").should("be.visible");
  cy.getCy("volunteercoordinatorcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Saving screenshot for VolunteerCoordinatorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Verified VolunteerCoordinatorComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Navigating to /staff/volunteer-coordinator-workflow (VolunteerCoordinatorWorkflowScreen)...");
  cy.visitWithSemantics("/staff/volunteer-coordinator-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Checking shell & content for VolunteerCoordinatorWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatorworkflow-screen").should("be.visible");
  cy.getCy("volunteercoordinatorworkflow-title").should("be.visible");
  cy.getCy("volunteercoordinatorworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Saving screenshot for VolunteerCoordinatorWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Verified VolunteerCoordinatorWorkflowScreen successfully!\n");

  });
});
