// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - training_director", () => {
  it("tests all screens for role training_director", () => {
    cy.loginAsRole("training_director");


  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/18 | 5%] - Navigating to /common/course-architect-dashboard (CourseArchitectDashboardScreen)...");
  cy.visitWithSemantics("/common/course-architect-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/18 | 5%] - Checking shell & content for CourseArchitectDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectdashboard-screen").should("be.visible");
  cy.getCy("coursearchitectdashboard-title").should("be.visible");
  cy.getCy("coursearchitectdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/18 | 5%] - Saving screenshot for CourseArchitectDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("course_architect_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/18 | 5%] - Verified CourseArchitectDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/18 | 11%] - Navigating to /offices/corporate/roles/training_director/dashboard (TrainingDirectorDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/18 | 11%] - Checking shell & content for TrainingDirectorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectordashboard-screen").should("be.visible");
  cy.getCy("trainingdirectordashboard-title").should("be.visible");
  cy.getCy("trainingdirectordashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/18 | 11%] - Saving screenshot for TrainingDirectorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("training_director_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/18 | 11%] - Verified TrainingDirectorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/18 | 16%] - Navigating to /common/course-architect-analytics (CourseArchitectAnalyticsScreen)...");
  cy.visitWithSemantics("/common/course-architect-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/18 | 16%] - Checking shell & content for CourseArchitectAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectanalytics-screen").should("be.visible");
  cy.getCy("coursearchitectanalytics-title").should("be.visible");
  cy.getCy("coursearchitectanalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/18 | 16%] - Saving screenshot for CourseArchitectAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("course_architect_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/18 | 16%] - Verified CourseArchitectAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/18 | 22%] - Navigating to /common/course-architect-workflow (CourseArchitectWorkflowScreen)...");
  cy.visitWithSemantics("/common/course-architect-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/18 | 22%] - Checking shell & content for CourseArchitectWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectworkflow-screen").should("be.visible");
  cy.getCy("coursearchitectworkflow-title").should("be.visible");
  cy.getCy("coursearchitectworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/18 | 22%] - Saving screenshot for CourseArchitectWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("course_architect_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/18 | 22%] - Verified CourseArchitectWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/18 | 27%] - Navigating to /offices/corporate/roles/training_director/analytics (TrainingDirectorAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/18 | 27%] - Checking shell & content for TrainingDirectorAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectoranalytics-screen").should("be.visible");
  cy.getCy("trainingdirectoranalytics-title").should("be.visible");
  cy.getCy("trainingdirectoranalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/18 | 27%] - Saving screenshot for TrainingDirectorAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("training_director_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/18 | 27%] - Verified TrainingDirectorAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/18 | 33%] - Navigating to /executive/training-director-compliance (TrainingDirectorComplianceScreen)...");
  cy.visitWithSemantics("/executive/training-director-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/18 | 33%] - Checking shell & content for TrainingDirectorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectorcompliance-screen").should("be.visible");
  cy.getCy("trainingdirectorcompliance-title").should("be.visible");
  cy.getCy("trainingdirectorcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/18 | 33%] - Saving screenshot for TrainingDirectorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("training_director_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/18 | 33%] - Verified TrainingDirectorComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/18 | 38%] - Navigating to /executive/training-director-workflow (TrainingDirectorWorkflowScreen)...");
  cy.visitWithSemantics("/executive/training-director-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/18 | 38%] - Checking shell & content for TrainingDirectorWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectorworkflow-screen").should("be.visible");
  cy.getCy("trainingdirectorworkflow-title").should("be.visible");
  cy.getCy("trainingdirectorworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/18 | 38%] - Saving screenshot for TrainingDirectorWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("training_director_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/18 | 38%] - Verified TrainingDirectorWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/18 | 44%] - Navigating to /offices/corporate/roles/training_director/assessments (Training Director Assessments)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/assessments");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/18 | 44%] - Checking shell & content for Training Director Assessments...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("training director assessments-screen").should("be.visible");
  cy.getCy("training director assessments-title").should("be.visible");
  cy.getCy("training director assessments-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/18 | 44%] - Saving screenshot for Training Director Assessments...");
  cy.waitAndSee();
  cy.screenshot("training_director_assessments");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/18 | 44%] - Verified Training Director Assessments successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/18 | 50%] - Navigating to /offices/corporate/roles/training_director/certificates (Training Director Certificates)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/certificates");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/18 | 50%] - Checking shell & content for Training Director Certificates...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("training director certificates-screen").should("be.visible");
  cy.getCy("training director certificates-title").should("be.visible");
  cy.getCy("training director certificates-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/18 | 50%] - Saving screenshot for Training Director Certificates...");
  cy.waitAndSee();
  cy.screenshot("training_director_certificates");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/18 | 50%] - Verified Training Director Certificates successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/18 | 55%] - Navigating to /offices/corporate/roles/training_director/certifications (Training Director Certifications)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/certifications");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/18 | 55%] - Checking shell & content for Training Director Certifications...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("training director certifications-screen").should("be.visible");
  cy.getCy("training director certifications-title").should("be.visible");
  cy.getCy("training director certifications-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/18 | 55%] - Saving screenshot for Training Director Certifications...");
  cy.waitAndSee();
  cy.screenshot("training_director_certifications");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/18 | 55%] - Verified Training Director Certifications successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/18 | 61%] - Navigating to /offices/corporate/roles/training_director/compliance-training (Training Director Compliance Training)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/compliance-training");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/18 | 61%] - Checking shell & content for Training Director Compliance Training...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("training director compliance training-screen").should("be.visible");
  cy.getCy("training director compliance training-title").should("be.visible");
  cy.getCy("training director compliance training-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/18 | 61%] - Saving screenshot for Training Director Compliance Training...");
  cy.waitAndSee();
  cy.screenshot("training_director_compliance_training");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/18 | 61%] - Verified Training Director Compliance Training successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/18 | 66%] - Navigating to /offices/corporate/roles/training_director/course-architect (Training Director Course Architect)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/course-architect");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/18 | 66%] - Checking shell & content for Training Director Course Architect...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("training director course architect-screen").should("be.visible");
  cy.getCy("training director course architect-title").should("be.visible");
  cy.getCy("training director course architect-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/18 | 66%] - Saving screenshot for Training Director Course Architect...");
  cy.waitAndSee();
  cy.screenshot("training_director_course_architect");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/18 | 66%] - Verified Training Director Course Architect successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/18 | 72%] - Navigating to /offices/corporate/roles/training_director/course-library (Training Director Course Library)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/course-library");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/18 | 72%] - Checking shell & content for Training Director Course Library...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("training director course library-screen").should("be.visible");
  cy.getCy("training director course library-title").should("be.visible");
  cy.getCy("training director course library-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/18 | 72%] - Saving screenshot for Training Director Course Library...");
  cy.waitAndSee();
  cy.screenshot("training_director_course_library");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/18 | 72%] - Verified Training Director Course Library successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/18 | 77%] - Navigating to /offices/corporate/roles/training_director/hub (Training Director Hub)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/hub");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/18 | 77%] - Checking shell & content for Training Director Hub...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("training director hub-screen").should("be.visible");
  cy.getCy("training director hub-title").should("be.visible");
  cy.getCy("training director hub-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/18 | 77%] - Saving screenshot for Training Director Hub...");
  cy.waitAndSee();
  cy.screenshot("training_director_hub");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/18 | 77%] - Verified Training Director Hub successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/18 | 83%] - Navigating to /offices/corporate/roles/training_director/reports (Training Director Reports)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/18 | 83%] - Checking shell & content for Training Director Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("training director reports-screen").should("be.visible");
  cy.getCy("training director reports-title").should("be.visible");
  cy.getCy("training director reports-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/18 | 83%] - Saving screenshot for Training Director Reports...");
  cy.waitAndSee();
  cy.screenshot("training_director_reports");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/18 | 83%] - Verified Training Director Reports successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/18 | 88%] - Navigating to /offices/corporate/roles/training_director/staff-training-matrix (Training Director Staff Training Matrix)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/staff-training-matrix");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/18 | 88%] - Checking shell & content for Training Director Staff Training Matrix...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("training director staff training matrix-screen").should("be.visible");
  cy.getCy("training director staff training matrix-title").should("be.visible");
  cy.getCy("training director staff training matrix-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/18 | 88%] - Saving screenshot for Training Director Staff Training Matrix...");
  cy.waitAndSee();
  cy.screenshot("training_director_staff_training_matrix");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/18 | 88%] - Verified Training Director Staff Training Matrix successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [17/18 | 94%] - Navigating to /offices/corporate/roles/training_director/trainer-assignments (Training Director Trainer Assignments)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/trainer-assignments");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [17/18 | 94%] - Checking shell & content for Training Director Trainer Assignments...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("training director trainer assignments-screen").should("be.visible");
  cy.getCy("training director trainer assignments-title").should("be.visible");
  cy.getCy("training director trainer assignments-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [17/18 | 94%] - Saving screenshot for Training Director Trainer Assignments...");
  cy.waitAndSee();
  cy.screenshot("training_director_trainer_assignments");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [17/18 | 94%] - Verified Training Director Trainer Assignments successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [18/18 | 100%] - Navigating to /offices/corporate/roles/training_director/training-programs (Training Director Training Programs)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/training-programs");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [18/18 | 100%] - Checking shell & content for Training Director Training Programs...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("training director training programs-screen").should("be.visible");
  cy.getCy("training director training programs-title").should("be.visible");
  cy.getCy("training director training programs-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [18/18 | 100%] - Saving screenshot for Training Director Training Programs...");
  cy.waitAndSee();
  cy.screenshot("training_director_training_programs");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [18/18 | 100%] - Verified Training Director Training Programs successfully!\n");

  });
});
