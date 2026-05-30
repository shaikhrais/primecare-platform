// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - training_director", () => {
  it("tests all screens for role training_director", () => {
    cy.loginAsRole("training_director");


  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/5 | 20%] - Navigating to /common/course-architect-dashboard (CourseArchitectDashboardScreen)...");
  cy.visitWithSemantics("/common/course-architect-dashboard");
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

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Navigating to /executive/training-director-dashboard (TrainingDirectorDashboardScreen)...");
  cy.visitWithSemantics("/executive/training-director-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Checking shell & content for TrainingDirectorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectordashboard-screen").should("be.visible");
  cy.getCy("trainingdirectordashboard-title").should("be.visible");
  cy.getCy("trainingdirectordashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Saving screenshot for TrainingDirectorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("training_director_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Verified TrainingDirectorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Navigating to /common/course-architect-analytics (CourseArchitectAnalyticsScreen)...");
  cy.visitWithSemantics("/common/course-architect-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Checking shell & content for CourseArchitectAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectanalytics-screen").should("be.visible");
  cy.getCy("coursearchitectanalytics-title").should("be.visible");
  cy.getCy("coursearchitectanalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Saving screenshot for CourseArchitectAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("course_architect_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Verified CourseArchitectAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Navigating to /common/course-architect-compliance (CourseArchitectComplianceScreen)...");
  cy.visitWithSemantics("/common/course-architect-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Checking shell & content for CourseArchitectComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectcompliance-screen").should("be.visible");
  cy.getCy("coursearchitectcompliance-title").should("be.visible");
  cy.getCy("coursearchitectcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Saving screenshot for CourseArchitectComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("course_architect_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Verified CourseArchitectComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Navigating to /common/course-architect-workflow (CourseArchitectWorkflowScreen)...");
  cy.visitWithSemantics("/common/course-architect-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Checking shell & content for CourseArchitectWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectworkflow-screen").should("be.visible");
  cy.getCy("coursearchitectworkflow-title").should("be.visible");
  cy.getCy("coursearchitectworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Saving screenshot for CourseArchitectWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("course_architect_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Verified CourseArchitectWorkflowScreen successfully!\n");

  });
});
