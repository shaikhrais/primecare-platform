// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - training_coordinator", () => {
  it("tests all screens for role training_coordinator", () => {
    cy.loginAsRole("training_coordinator");


  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/15 | 6%] - Navigating to /offices/support/roles/training_coordinator/dashboard (TrainingCoordinatorDashboardScreen)...");
  cy.visitWithSemantics("/offices/support/roles/training_coordinator/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/15 | 6%] - Checking shell & content for TrainingCoordinatorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatordashboard-screen").should("be.visible");
  cy.getCy("trainingcoordinatordashboard-title").should("be.visible");
  cy.getCy("trainingcoordinatordashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/15 | 6%] - Saving screenshot for TrainingCoordinatorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/15 | 6%] - Verified TrainingCoordinatorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/15 | 13%] - Navigating to /staff/training-coordinator-analytics (TrainingCoordinatorAnalyticsScreen)...");
  cy.visitWithSemantics("/staff/training-coordinator-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/15 | 13%] - Checking shell & content for TrainingCoordinatorAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatoranalytics-screen").should("be.visible");
  cy.getCy("trainingcoordinatoranalytics-title").should("be.visible");
  cy.getCy("trainingcoordinatoranalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/15 | 13%] - Saving screenshot for TrainingCoordinatorAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/15 | 13%] - Verified TrainingCoordinatorAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/15 | 20%] - Navigating to /staff/training-coordinator-compliance (TrainingCoordinatorComplianceScreen)...");
  cy.visitWithSemantics("/staff/training-coordinator-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/15 | 20%] - Checking shell & content for TrainingCoordinatorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatorcompliance-screen").should("be.visible");
  cy.getCy("trainingcoordinatorcompliance-title").should("be.visible");
  cy.getCy("trainingcoordinatorcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/15 | 20%] - Saving screenshot for TrainingCoordinatorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/15 | 20%] - Verified TrainingCoordinatorComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/15 | 26%] - Navigating to /staff/training-coordinator-workflow (TrainingCoordinatorWorkflowScreen)...");
  cy.visitWithSemantics("/staff/training-coordinator-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/15 | 26%] - Checking shell & content for TrainingCoordinatorWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatorworkflow-screen").should("be.visible");
  cy.getCy("trainingcoordinatorworkflow-title").should("be.visible");
  cy.getCy("trainingcoordinatorworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/15 | 26%] - Saving screenshot for TrainingCoordinatorWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/15 | 26%] - Verified TrainingCoordinatorWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/15 | 33%] - Navigating to /staff/course-assignment (CourseAssignmentScreen)...");
  cy.visitWithSemantics("/staff/course-assignment");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/15 | 33%] - Checking shell & content for CourseAssignmentScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("courseassignment-screen").should("be.visible");
  cy.getCy("courseassignment-title").should("be.visible");
  cy.getCy("courseassignment-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/15 | 33%] - Saving screenshot for CourseAssignmentScreen...");
  cy.waitAndSee();
  cy.screenshot("course_assignment");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/15 | 33%] - Verified CourseAssignmentScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/15 | 40%] - Navigating to /staff/certification-tracking (CertificationTrackingScreen)...");
  cy.visitWithSemantics("/staff/certification-tracking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/15 | 40%] - Checking shell & content for CertificationTrackingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("certificationtracking-screen").should("be.visible");
  cy.getCy("certificationtracking-title").should("be.visible");
  cy.getCy("certificationtracking-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/15 | 40%] - Saving screenshot for CertificationTrackingScreen...");
  cy.waitAndSee();
  cy.screenshot("certification_tracking");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/15 | 40%] - Verified CertificationTrackingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/15 | 46%] - Navigating to /staff/staff-progress (StaffProgressScreen)...");
  cy.visitWithSemantics("/staff/staff-progress");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/15 | 46%] - Checking shell & content for StaffProgressScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffprogress-screen").should("be.visible");
  cy.getCy("staffprogress-title").should("be.visible");
  cy.getCy("staffprogress-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/15 | 46%] - Saving screenshot for StaffProgressScreen...");
  cy.waitAndSee();
  cy.screenshot("staff_progress");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/15 | 46%] - Verified StaffProgressScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/15 | 53%] - Navigating to None (Training Coordinator Attendance)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/15 | 53%] - Checking shell & content for Training Coordinator Attendance...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("training coordinator attendance-screen").should("be.visible");
  cy.getCy("training coordinator attendance-title").should("be.visible");
  cy.getCy("training coordinator attendance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/15 | 53%] - Saving screenshot for Training Coordinator Attendance...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_attendance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/15 | 53%] - Verified Training Coordinator Attendance successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/15 | 60%] - Navigating to None (Training Coordinator Certifications)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/15 | 60%] - Checking shell & content for Training Coordinator Certifications...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("training coordinator certifications-screen").should("be.visible");
  cy.getCy("training coordinator certifications-title").should("be.visible");
  cy.getCy("training coordinator certifications-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/15 | 60%] - Saving screenshot for Training Coordinator Certifications...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_certifications");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/15 | 60%] - Verified Training Coordinator Certifications successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/15 | 66%] - Navigating to None (Training Coordinator Courses)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/15 | 66%] - Checking shell & content for Training Coordinator Courses...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("training coordinator courses-screen").should("be.visible");
  cy.getCy("training coordinator courses-title").should("be.visible");
  cy.getCy("training coordinator courses-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/15 | 66%] - Saving screenshot for Training Coordinator Courses...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_courses");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/15 | 66%] - Verified Training Coordinator Courses successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [11/15 | 73%] - Navigating to None (Training Coordinator Materials)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [11/15 | 73%] - Checking shell & content for Training Coordinator Materials...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("training coordinator materials-screen").should("be.visible");
  cy.getCy("training coordinator materials-title").should("be.visible");
  cy.getCy("training coordinator materials-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [11/15 | 73%] - Saving screenshot for Training Coordinator Materials...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_materials");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [11/15 | 73%] - Verified Training Coordinator Materials successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [12/15 | 80%] - Navigating to None (Training Coordinator Progress)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [12/15 | 80%] - Checking shell & content for Training Coordinator Progress...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("training coordinator progress-screen").should("be.visible");
  cy.getCy("training coordinator progress-title").should("be.visible");
  cy.getCy("training coordinator progress-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [12/15 | 80%] - Saving screenshot for Training Coordinator Progress...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_progress");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [12/15 | 80%] - Verified Training Coordinator Progress successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/15 | 86%] - Navigating to None (Training Coordinator Reports)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/15 | 86%] - Checking shell & content for Training Coordinator Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("training coordinator reports-screen").should("be.visible");
  cy.getCy("training coordinator reports-title").should("be.visible");
  cy.getCy("training coordinator reports-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/15 | 86%] - Saving screenshot for Training Coordinator Reports...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_reports");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/15 | 86%] - Verified Training Coordinator Reports successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [14/15 | 93%] - Navigating to None (Training Coordinator Training Schedule)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [14/15 | 93%] - Checking shell & content for Training Coordinator Training Schedule...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("training coordinator training schedule-screen").should("be.visible");
  cy.getCy("training coordinator training schedule-title").should("be.visible");
  cy.getCy("training coordinator training schedule-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [14/15 | 93%] - Saving screenshot for Training Coordinator Training Schedule...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_training_schedule");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [14/15 | 93%] - Verified Training Coordinator Training Schedule successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [15/15 | 100%] - Navigating to None (Training Coordinator Workshops)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [15/15 | 100%] - Checking shell & content for Training Coordinator Workshops...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("training coordinator workshops-screen").should("be.visible");
  cy.getCy("training coordinator workshops-title").should("be.visible");
  cy.getCy("training coordinator workshops-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [15/15 | 100%] - Saving screenshot for Training Coordinator Workshops...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_workshops");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [15/15 | 100%] - Verified Training Coordinator Workshops successfully!\n");

  });
});
