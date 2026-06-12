// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - training", () => {
  it("tests all screens for role training", () => {
    cy.loginAsRole("training");


  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/5 | 20%] - Navigating to packages/primecare_ui/lib/src/screens/common/course_architect_dashboard_screen.dart (CourseArchitectDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/common/course_architect_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/5 | 20%] - Checking shell & content for CourseArchitectDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectdashboard-screen").should("be.visible");
  cy.getCy("coursearchitectdashboard-title").should("be.visible");
  cy.getCy("coursearchitectdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/5 | 20%] - Saving screenshot for CourseArchitectDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("course_architect_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/5 | 20%] - Verified CourseArchitectDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Navigating to packages/primecare_ui/lib/src/screens/common/training_hub_dashboard_screen.dart (TrainingHubDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/common/training_hub_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Checking shell & content for TrainingHubDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("traininghubdashboard-screen").should("be.visible");
  cy.getCy("traininghubdashboard-title").should("be.visible");
  cy.getCy("traininghubdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Saving screenshot for TrainingHubDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("training_hub_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Verified TrainingHubDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Navigating to /offices/corporate/roles/training_director/dashboard (TrainingDirectorDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Checking shell & content for TrainingDirectorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectordashboard-screen").should("be.visible");
  cy.getCy("trainingdirectordashboard-title").should("be.visible");
  cy.getCy("trainingdirectordashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Saving screenshot for TrainingDirectorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("training_director_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Verified TrainingDirectorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Navigating to /offices/support/roles/training_coordinator/dashboard (TrainingCoordinatorDashboardScreen)...");
  cy.visitWithSemantics("/offices/support/roles/training_coordinator/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Checking shell & content for TrainingCoordinatorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatordashboard-screen").should("be.visible");
  cy.getCy("trainingcoordinatordashboard-title").should("be.visible");
  // cy.getCy("trainingcoordinatordashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Saving screenshot for TrainingCoordinatorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Verified TrainingCoordinatorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Navigating to packages/primecare_ui/lib/src/screens/staff/training_dashboard_screen.dart (TrainingDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/staff/training_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Checking shell & content for TrainingDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdashboard-screen").should("be.visible");
  cy.getCy("trainingdashboard-title").should("be.visible");
  cy.getCy("trainingdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Saving screenshot for TrainingDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("training_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Verified TrainingDashboardScreen successfully!\n");

  });
});
